import { useEffect, useState } from 'react'

import './FaqPage.css'

import { fetchFaqs, type FaqItemData } from './faqData'

export function FaqPage() {
    const [faqItems, setFaqItems] = useState<FaqItemData[]>([])
    const [openId, setOpenId] = useState<number | null>(null)
    const [status, setStatus] = useState<'loading' | 'ready' | 'error'>('loading')

    useEffect(() => {
        let cancelled = false

        fetchFaqs()
            .then((items) => {
                if (cancelled) {
                    return
                }
                setFaqItems(items)
                setOpenId(items[1]?.id ?? items[0]?.id ?? null)
                setStatus('ready')
            })
            .catch(() => {
                if (!cancelled) {
                    setStatus('error')
                }
            })

        return () => {
            cancelled = true
        }
    }, [])

    function toggleItem(id: number) {
        setOpenId((current) => (current === id ? null : id))
    }

    return (
        <div id="faq-page">
                <div className="background-container">
                    <section id="faq-content">
                        <div className="faq-intro">
                            <h1>FAQ</h1>
                            <p className="b2">
                                Ответы на частые вопросы о тренажёре, формате подготовки
                                и том, как устроены обучение и экзамен.
                            </p>
                        </div>

                        <div className="faq-list">
                            <img
                                id="faq-zigzag"
                                className="part"
                                src="/assets/Vector7.svg"
                                alt=""
                            />
                            {status === 'loading' && (
                                <p className="b2 faq-status">Загружаем вопросы…</p>
                            )}
                            {status === 'error' && (
                                <p className="b2 faq-status">Не удалось загрузить вопросы. Попробуйте обновить страницу.</p>
                            )}
                            {faqItems.map((item) => {
                                const isOpen = openId === item.id
                                const answerId = `faq-answer-${item.id}`

                                return (
                                    <article
                                        key={item.id}
                                        className={`faq-item${isOpen ? ' faq-item--open' : ''}`}
                                    >
                                        <button
                                            type="button"
                                            className="faq-item-trigger"
                                            aria-expanded={isOpen}
                                            aria-controls={answerId}
                                            onClick={() => toggleItem(item.id)}
                                        >
                                            <h3>{item.title}</h3>
                                            <span className="faq-chevron" aria-hidden="true" />
                                        </button>
                                        <div className="faq-item-answer" id={answerId}>
                                            <div className="faq-item-answer-inner">
                                                <p className="b3">{item.description}</p>
                                            </div>
                                        </div>
                                    </article>
                                )
                            })}
                        </div>
                    </section>
                    <img
                        id="faq-arrow"
                        className="part"
                        src="/assets/Vector2.svg"
                        alt=""
                    />
                </div>
        </div>
    )
}
