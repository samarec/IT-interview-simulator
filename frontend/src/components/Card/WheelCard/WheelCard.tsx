import { useEffect, useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'

import './WheelCard.css'

import type { Profession, ProfessionMatchResult } from '../../../api/professions'
import { fetchTests, type TestInfo } from '../../../api/tests'
import { Button } from '../../Buttons/Button'

const WHEEL_COLORS = ['#0F89FF', '#FF936B', '#45A4FF', '#FFCEBC', '#162B3B', '#ABD6FF']
const SPIN_TURNS = 5
const SPIN_MS = 4200

function shuffle<T>(items: T[]): T[] {
    const next = [...items]
    for (let index = next.length - 1; index > 0; index -= 1) {
        const swapIndex = Math.floor(Math.random() * (index + 1))
        ;[next[index], next[swapIndex]] = [next[swapIndex], next[index]]
    }
    return next
}

function shortName(name: string): string {
    const first = name.split(/[\s-]+/)[0] || name
    return first.length > 12 ? `${first.slice(0, 11)}…` : first
}

function buildWheelItems(match: ProfessionMatchResult): Profession[] {
    return shuffle([match.correct_profession, ...match.wheel_professions])
}

export function WheelCard(props: {
    match: ProfessionMatchResult | null
    playerName: string
}) {
    const navigate = useNavigate()
    const [items, setItems] = useState<Profession[]>([])
    const [rotation, setRotation] = useState(0)
    const [isSpinning, setIsSpinning] = useState(false)
    const [showResult, setShowResult] = useState(false)
    const [tests, setTests] = useState<TestInfo[]>([])

    useEffect(() => {
        if (!props.match) {
            return
        }

        const nextItems = buildWheelItems(props.match)
        const correctIndex = nextItems.findIndex((item) => item.id === props.match?.correct_profession.id)
        const segmentAngle = 360 / nextItems.length
        const target = SPIN_TURNS * 360 + (360 - (correctIndex * segmentAngle + segmentAngle / 2))

        setItems(nextItems)
        setShowResult(false)
        setIsSpinning(false)
        setRotation(0)

        const start = window.setTimeout(() => {
            setIsSpinning(true)
            setRotation(target)
        }, 80)
        const finish = window.setTimeout(() => {
            setIsSpinning(false)
            setShowResult(true)
        }, SPIN_MS + 80)

        return () => {
            window.clearTimeout(start)
            window.clearTimeout(finish)
        }
    }, [props.match])

    useEffect(() => {
        if (!props.match) {
            return
        }

        let cancelled = false
        fetchTests()
            .then((list) => {
                if (!cancelled) {
                    setTests(list)
                }
            })
            .catch(() => {
                if (!cancelled) {
                    setTests([])
                }
            })

        return () => {
            cancelled = true
        }
    }, [props.match])

    const conicGradient = useMemo(() => {
        if (items.length === 0) {
            return 'conic-gradient(#ABD6FF 0 50%, #FFCEBC 50% 100%)'
        }

        const segmentAngle = 360 / items.length
        const stops = items.map((_, index) => {
            const color = WHEEL_COLORS[index % WHEEL_COLORS.length]
            const start = index * segmentAngle
            const end = start + segmentAngle
            return `${color} ${start}deg ${end}deg`
        })
        return `conic-gradient(${stops.join(', ')})`
    }, [items])

    const relatedTest = tests.find((test) => test.profession_id === props.match?.correct_profession.id)
    const resultName = props.match?.correct_profession.name
    const resultDescription = props.match?.correct_profession.description

    return (
        <section id="wheel-card">
            <h2>Крути колесо — узнай свою профессию!</h2>
            <p className="b2 wheel-card-lead">
                {props.match
                    ? 'Колесо уже знает ответ. Осталось дождаться остановки.'
                    : 'Выбери интересы в анкете выше — и колесо подберёт направление.'}
            </p>

            <div className="wheel-stage">
                <div className="wheel-pointer" />
                <div
                    className={`wheel-disk${isSpinning ? ' wheel-disk--spinning' : ''}`}
                    style={{
                        background: conicGradient,
                        transform: `rotate(${rotation}deg)`,
                    }}
                >
                    {items.map((item, index) => {
                        const angle = (360 / items.length) * index + 360 / items.length / 2
                        return (
                            <span
                                key={item.id}
                                className="wheel-label"
                                style={{ transform: `rotate(${angle}deg) translateY(var(--wheel-label-offset, -148px))` }}
                            >
                                {shortName(item.name)}
                            </span>
                        )
                    })}
                </div>
            </div>

            {showResult && props.match && (
                <div className="wheel-result gradient-wight-card-fill">
                    <p className="b3 wheel-result-label">
                        {props.playerName ? `${props.playerName}, тебе подходит` : 'Тебе подходит'}
                    </p>
                    <h3>{resultName}</h3>
                    {resultDescription && <p className="b2">{resultDescription}</p>}
                    <Button
                        text={relatedTest ? 'Пройти тест' : 'Смотреть тесты'}
                        onClick={() => navigate(relatedTest ? `/test/${relatedTest.code}` : '/test')}
                        classes={['but2', 'main-button']}
                    />
                </div>
            )}
        </section>
    )
}
