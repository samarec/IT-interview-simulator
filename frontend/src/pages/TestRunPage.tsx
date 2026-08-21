import { useEffect, useMemo, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'

import './TestSession.css'

import { fetchTestCards, submitTest, type TestDetail, type TestMode } from '../api/tests'
import { Button } from '../components/Buttons/Button'
import { useAuth } from '../context/AuthContext'
import { getSkillIcon } from '../data/skillIcons'

function resultCopy(correct: number, total: number) {
    if (total > 0 && correct === total) {
        return {
            title: 'Идеально',
            text: 'Вы ответили правильно на все вопросы. Так держать!',
        }
    }
    if (total > 0 && correct / total >= 0.8) {
        return {
            title: 'Отлично',
            text: 'Сильный результат. Осталось чуть-чуть до идеала.',
        }
    }
    if (total > 0 && correct / total >= 0.6) {
        return {
            title: 'Хорошо',
            text: 'База есть. Повторите ошибки и пройдите тест ещё раз.',
        }
    }
    return {
        title: 'Есть что повторить',
        text: 'Не страшно: разберите вопросы и попробуйте снова.',
    }
}

function ScoreRing(props: { correct: number; total: number }) {
    const size = 112
    const stroke = 10
    const radius = (size - stroke) / 2
    const length = 2 * Math.PI * radius
    const progress = props.total ? props.correct / props.total : 0

    return (
        <svg className="test-score-ring" width={size} height={size} viewBox={`0 0 ${size} ${size}`}>
            <circle
                cx={size / 2}
                cy={size / 2}
                r={radius}
                fill="none"
                stroke="rgba(15, 137, 255, 0.16)"
                strokeWidth={stroke}
            />
            <circle
                className="test-score-ring-value"
                cx={size / 2}
                cy={size / 2}
                r={radius}
                fill="none"
                stroke="url(#test-score-gradient)"
                strokeWidth={stroke}
                strokeLinecap="round"
                strokeDasharray={length}
                strokeDashoffset={length * (1 - progress)}
                transform={`rotate(-90 ${size / 2} ${size / 2})`}
            />
            <defs>
                <linearGradient id="test-score-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" stopColor="#ABD6FF" />
                    <stop offset="100%" stopColor="#0F89FF" />
                </linearGradient>
            </defs>
            <text x="50%" y="50%" textAnchor="middle" dominantBaseline="central">
                {props.correct}/{props.total}
            </text>
        </svg>
    )
}

export function TestRunPage() {
    const { code, mode } = useParams<{ code: string; mode: string }>()
    const navigate = useNavigate()
    const { token } = useAuth()
    const testMode: TestMode = mode === 'exam' ? 'exam' : 'training'
    const [detail, setDetail] = useState<TestDetail | null>(null)
    const [status, setStatus] = useState<'loading' | 'ready' | 'error'>('loading')
    const [index, setIndex] = useState(0)
    const [selected, setSelected] = useState<Record<number, number>>({})
    const [checked, setChecked] = useState<Record<number, boolean>>({})
    const [finished, setFinished] = useState(false)
    const [correctCount, setCorrectCount] = useState(0)
    const [isSubmitting, setIsSubmitting] = useState(false)

    useEffect(() => {
        if (!code || (mode !== 'training' && mode !== 'exam')) {
            setStatus('error')
            return
        }

        let cancelled = false
        setStatus('loading')
        setIndex(0)
        setSelected({})
        setChecked({})
        setFinished(false)
        setCorrectCount(0)

        fetchTestCards(code, testMode)
            .then((item) => {
                if (!cancelled) {
                    setDetail(item)
                    setStatus('ready')
                }
            })
            .catch(() => {
                if (!cancelled) {
                    setStatus('error')
                }
            })

        return () => {
            cancelled = true
        }
    }, [code, mode, testMode])

    const cards = detail?.cards ?? []
    const card = cards[index]
    const isLast = index === cards.length - 1
    const isChecked = Boolean(card && checked[card.id])
    const selectedId = card ? selected[card.id] : undefined

    const localCorrect = useMemo(() => {
        if (!detail) {
            return 0
        }
        return detail.cards.filter((item) => {
            const answer = item.answers.find((option) => option.id === selected[item.id])
            return Boolean(answer?.is_correct)
        }).length
    }, [detail, selected])

    async function finishTest() {
        if (!code || !detail || isSubmitting) {
            return
        }

        setIsSubmitting(true)
        const payload = Object.entries(selected).map(([cardId, answerId]) => ({
            card_id: Number(cardId),
            answer_id: answerId,
        }))

        try {
            const result = await submitTest(code, payload, token)
            setCorrectCount(result.correct_count)
        } catch {
            setCorrectCount(localCorrect)
        } finally {
            setFinished(true)
            setIsSubmitting(false)
        }
    }

    function handleAnswer() {
        if (!card || selectedId == null) {
            return
        }

        if (testMode === 'training') {
            if (!isChecked) {
                setChecked((current) => ({ ...current, [card.id]: true }))
                return
            }
            if (isLast) {
                void finishTest()
                return
            }
            setIndex((current) => current + 1)
            return
        }

        if (isLast) {
            void finishTest()
            return
        }
        setIndex((current) => current + 1)
    }

    function answerClass(answerId: number, isCorrect?: boolean | null) {
        const classes = ['test-answer', 'gradient-wight-card-fill']
        if (selectedId === answerId) {
            classes.push('test-answer--selected')
        }
        if (testMode === 'training' && isChecked) {
            if (isCorrect) {
                classes.push('test-answer--correct')
            } else if (selectedId === answerId) {
                classes.push('test-answer--wrong')
            }
        }
        return classes.join(' ')
    }

    if (status === 'loading') {
        return (
            <div className="test-session">
                <p className="b2 test-session-status">Загружаем вопросы…</p>
            </div>
        )
    }

    if (status === 'error' || !detail || !card) {
        return (
            <div className="test-session">
                <p className="b2 test-session-status">Не удалось открыть тест.</p>
                <Button text="Назад" onClick={() => navigate(code ? `/test/${code}` : '/test')} classes={['but2', 'main-button']} />
            </div>
        )
    }

    if (finished) {
        const copy = resultCopy(correctCount, detail.cards_count)
        const icon = getSkillIcon([], detail.name)

        return (
            <div className="test-session test-result">
                <h1>Тест завершён!</h1>
                <p className="test-result-subtitle">{detail.name}</p>
                {icon && <img className="test-session-hero" src={icon} alt="" />}
                <div className="test-result-main gradient-wight-card-fill">
                    <ScoreRing correct={correctCount} total={detail.cards_count} />
                    <div>
                        <h2>{copy.title}</h2>
                        <p className="b2">{copy.text}</p>
                    </div>
                </div>
                <div className="test-intro-stats">
                    <div className="test-intro-stat gradient-wight-card-fill">
                        <strong>{detail.cards_count}</strong>
                        <span>Вопросов</span>
                    </div>
                    <div className="test-intro-stat gradient-wight-card-fill">
                        <strong className="test-stat-correct">{correctCount}</strong>
                        <span>Правильно</span>
                    </div>
                </div>
                <Button
                    text="Вернуться на главную"
                    onClick={() => navigate('/')}
                    classes={['but1', 'main-button']}
                />
            </div>
        )
    }

    const buttonText = testMode === 'training'
        ? (isChecked ? (isLast ? 'Завершить' : 'Далее') : 'Ответить')
        : (isLast ? 'Завершить' : 'Ответить')

    return (
        <div className="test-session test-run">
            <div className="test-progress">
                <button
                    type="button"
                    className="test-progress-arrow"
                    onClick={() => setIndex((current) => Math.max(0, current - 1))}
                    disabled={index === 0}
                    aria-label="Предыдущий вопрос"
                >
                    ‹
                </button>
                <div className="test-progress-list">
                    {cards.map((item, itemIndex) => {
                        const answerId = selected[item.id]
                        const answered = answerId != null
                        const isCurrent = itemIndex === index
                        const wasChecked = Boolean(checked[item.id])

                        let dotClass = ''
                        if (answered) {
                            if (wasChecked) {
                                const chosen = item.answers.find((a) => a.id === answerId)
                                dotClass = chosen?.is_correct
                                    ? 'test-progress-dot--correct'
                                    : 'test-progress-dot--wrong'
                            } else {
                                dotClass = 'test-progress-dot--neutral'
                            }
                        }

                        return (
                            <button
                                key={item.id}
                                type="button"
                                className={[
                                    'test-progress-item',
                                    isCurrent ? 'test-progress-item--current' : '',
                                    answered ? 'test-progress-item--answered' : '',
                                ].join(' ')}
                                onClick={() => setIndex(itemIndex)}
                            >
                                {answered && <span className={`test-progress-dot ${dotClass}`} />}
                                {itemIndex + 1}
                            </button>
                        )
                    })}
                </div>
                <button
                    type="button"
                    className="test-progress-arrow"
                    onClick={() => setIndex((current) => Math.min(cards.length - 1, current + 1))}
                    disabled={index === cards.length - 1}
                    aria-label="Следующий вопрос"
                >
                    ›
                </button>
            </div>

            <div className="test-question">
                <h2>{card.title}</h2>
                <p className="b3">Выберите один вариант ответа</p>
            </div>

            <div className="test-answers">
                {card.answers.map((answer) => (
                    <button
                        key={answer.id}
                        type="button"
                        className={answerClass(answer.id, answer.is_correct)}
                        onClick={() => {
                            if (testMode === 'training' && isChecked) {
                                return
                            }
                            setSelected((current) => ({ ...current, [card.id]: answer.id }))
                        }}
                    >
                        <span className="test-answer-radio" />
                        <span>{answer.title}</span>
                    </button>
                ))}
            </div>

            <Button
                text={isSubmitting ? 'Сохраняем…' : buttonText}
                onClick={handleAnswer}
                disabled={selectedId == null || isSubmitting}
                classes={['but1', 'main-button']}
            />
        </div>
    )
}
