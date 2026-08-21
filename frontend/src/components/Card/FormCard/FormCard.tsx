import { useEffect, useMemo, useState } from 'react'

import './FormCard.css'

import { matchProfession, type ProfessionMatchResult } from '../../../api/professions'
import { fetchTopics, type TopicTag } from '../../../api/topics'
import { Input } from '../../Input/Input'
import { Button } from '../../Buttons/Button'
import { WheelCard } from '../WheelCard/WheelCard'

const MAX_INTERESTS = 5

function uniqueTags(topics: Array<{ tags: TopicTag[] }>): TopicTag[] {
    const tags = new Map<number, TopicTag>()
    topics.forEach((topic) => {
        topic.tags.forEach((tag) => {
            tags.set(tag.id, tag)
        })
    })
    return Array.from(tags.values())
}

const TAG_ROWS = 3

function splitTagRows(tags: TopicTag[]): TopicTag[][] {
    const perRow = Math.ceil(tags.length / TAG_ROWS) || 1
    return Array.from({ length: TAG_ROWS }, (_, index) => (
        tags.slice(index * perRow, (index + 1) * perRow)
    )).filter((row) => row.length > 0)
}

export function FormCard(props: {
    onMatched?: (result: ProfessionMatchResult, name: string) => void
}) {
    const [name, setName] = useState('')
    const [tags, setTags] = useState<TopicTag[]>([])
    const [selectedTagIds, setSelectedTagIds] = useState<number[]>([])
    const [tagsStatus, setTagsStatus] = useState<'loading' | 'ready' | 'error'>('loading')
    const [isSubmitting, setIsSubmitting] = useState(false)
    const [error, setError] = useState('')
    const [match, setMatch] = useState<ProfessionMatchResult | null>(null)
    const [playerName, setPlayerName] = useState('')
    const [phase, setPhase] = useState<'form' | 'leaving' | 'wheel'>('form')

    useEffect(() => {
        let cancelled = false

        fetchTopics()
            .then((topics) => {
                if (!cancelled) {
                    setTags(uniqueTags(topics))
                    setTagsStatus('ready')
                }
            })
            .catch(() => {
                if (!cancelled) {
                    setTagsStatus('error')
                }
            })

        return () => {
            cancelled = true
        }
    }, [])

    const tagRows = useMemo(() => splitTagRows(tags), [tags])

    function toggleTag(tagId: number) {
        setSelectedTagIds((current) => {
            if (current.includes(tagId)) {
                return current.filter((id) => id !== tagId)
            }
            if (current.length >= MAX_INTERESTS) {
                return current
            }
            return [...current, tagId]
        })
    }

    async function handleSubmit() {
        setError('')
        setIsSubmitting(true)

        try {
            const result = await matchProfession(selectedTagIds)
            const trimmedName = name.trim()
            setPlayerName(trimmedName)
            setMatch(result)
            props.onMatched?.(result, trimmedName)
            setPhase('leaving')
            window.setTimeout(() => setPhase('wheel'), 380)
        } catch (submitError) {
            setError(submitError instanceof Error ? submitError.message : 'Не удалось подобрать профессию')
            setIsSubmitting(false)
        }
    }

    return (
        <div className="background-container">
            <section id="form-card">
                <div id="form-intro">
                    <h1>Не знаешь, с чего начать?</h1>
                    <p className="b2">
                        Заполни анкету, и мы подберем идеальное IT-направление под твой вайб.
                    </p>
                </div>
                <div
                    className={`form-container gradient-wight-card-fill${phase === 'wheel' ? ' form-container--wheel' : ''}`}
                >
                    {phase !== 'wheel' && (
                        <div className={`form-panel${phase === 'leaving' ? ' form-panel--leave' : ''}`}>
                            <div className="form">
                                <h2>Анкета</h2>
                                <Input text="Имя" name="name" autoComplete="name" value={name} onChange={setName} />
                                <div>
                                    <p className="b2">Выбери до 5 интересов:</p>
                                    {tagsStatus === 'loading' && (
                                        <p className="b3 form-card-status">Загружаем интересы…</p>
                                    )}
                                    {tagsStatus === 'error' && (
                                        <p className="b3 form-card-status form-card-status--error">
                                            Не удалось загрузить интересы.
                                        </p>
                                    )}
                                    <div className="form-buttons">
                                        {tagRows.map((row) => (
                                            <div className="form-buttons-row" key={row[0]?.id ?? 'row'}>
                                                {row.map((tag) => (
                                                    <Button
                                                        key={tag.id}
                                                        text={tag.name}
                                                        onClick={() => toggleTag(tag.id)}
                                                        disabled={isSubmitting}
                                                        classes={[
                                                            'form-button',
                                                            selectedTagIds.includes(tag.id) ? 'form-button--selected' : '',
                                                        ]}
                                                    />
                                                ))}
                                            </div>
                                        ))}
                                    </div>
                                </div>
                            </div>
                            {error && <p className="b3 form-card-status form-card-status--error">{error}</p>}
                            <Button
                                text={isSubmitting ? 'Подбираем…' : 'Подобрать профессию'}
                                classes={['but1', 'main-button']}
                                disabled={selectedTagIds.length === 0 || isSubmitting || tagsStatus !== 'ready'}
                                onClick={() => void handleSubmit()}
                            />
                        </div>
                    )}
                    {phase === 'wheel' && match && (
                        <div className="form-panel form-panel--enter">
                            <WheelCard match={match} playerName={playerName} />
                        </div>
                    )}
                </div>
            </section>
            <img id="vector2-background-form" className="part" src="/assets/Vector2.svg" alt="" />
            <img id="group3-background-form" className="part" src="/assets/Group3.svg" alt="" />
        </div>
    )
}
