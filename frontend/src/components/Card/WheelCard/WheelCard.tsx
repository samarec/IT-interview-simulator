import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'

import './WheelCard.css'

import type { Profession, ProfessionMatchResult } from '../../../api/professions'
import { fetchTests, type TestInfo } from '../../../api/tests'
import { getSkillIcon } from '../../../data/skillIcons'
import { Button } from '../../Buttons/Button'

const SEGMENT_COUNT = 8
const SEGMENT_ANGLE = 360 / SEGMENT_COUNT
const SPIN_TURNS = 6
const SPIN_MS = 4200

function shuffle<T>(items: T[]): T[] {
    const next = [...items]
    for (let index = next.length - 1; index > 0; index -= 1) {
        const swapIndex = Math.floor(Math.random() * (index + 1))
        ;[next[index], next[swapIndex]] = [next[swapIndex], next[index]]
    }
    return next
}

function buildWheelItems(match: ProfessionMatchResult): Profession[] {
    const unique: Profession[] = []
    const seen = new Set<number>()
    for (const item of [match.correct_profession, ...match.wheel_professions]) {
        if (!seen.has(item.id)) {
            seen.add(item.id)
            unique.push(item)
        }
    }

    const items = shuffle(unique)
    while (items.length < SEGMENT_COUNT && unique.length > 0) {
        items.push(unique[items.length % unique.length])
    }
    return items.slice(0, SEGMENT_COUNT)
}

export function WheelCard(props: {
    match: ProfessionMatchResult
    playerName: string
}) {
    const navigate = useNavigate()
    const [items, setItems] = useState<Profession[]>([])
    const [rotation, setRotation] = useState(0)
    const [isSpinning, setIsSpinning] = useState(false)
    const [showResult, setShowResult] = useState(false)
    const [tests, setTests] = useState<TestInfo[]>([])

    useEffect(() => {
        const nextItems = buildWheelItems(props.match)
        const correctIndex = nextItems.findIndex((item) => item.id === props.match.correct_profession.id)
        const target = SPIN_TURNS * 360 + (360 - (correctIndex * SEGMENT_ANGLE + SEGMENT_ANGLE / 2))

        setItems(nextItems)
        setShowResult(false)
        setIsSpinning(false)
        setRotation(0)

        const start = window.setTimeout(() => {
            setIsSpinning(true)
            setRotation(target)
        }, 280)
        const finish = window.setTimeout(() => {
            setIsSpinning(false)
            setShowResult(true)
        }, SPIN_MS + 280)

        return () => {
            window.clearTimeout(start)
            window.clearTimeout(finish)
        }
    }, [props.match])

    useEffect(() => {
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
    }, [])

    const relatedTest = tests.find((test) => test.profession_id === props.match.correct_profession.id)

    return (
        <div className="wheel-embed">
            <div className="wheel-half">
                <img className="wheel-motion wheel-motion--left" src="/assets/Group5.svg" alt="" />
                <img className="wheel-motion wheel-motion--right" src="/assets/Group5.svg" alt="" />

                <div className="wheel-pointer" aria-hidden="true" />

                <div className="wheel-rotator-wrap">
                    <div
                        className={`wheel-rotator${isSpinning ? ' wheel-rotator--spinning' : ''}`}
                        style={{ transform: `rotate(${rotation}deg)` }}
                    >
                        <img className="wheel-disk-img" src="/assets/wheel-disk.svg" alt="" />
                        {items.map((item, index) => {
                            const angle = index * SEGMENT_ANGLE + SEGMENT_ANGLE / 2
                            const icon = getSkillIcon(item.tags ?? [], item.name)
                            return (
                                <div
                                    key={`${item.id}-${index}`}
                                    className="wheel-spoke"
                                    style={{ transform: `rotate(${angle}deg)` }}
                                >
                                    <div className="wheel-item">
                                        <span>{item.name}</span>
                                        {icon && <img src={icon} alt="" />}
                                    </div>
                                </div>
                            )
                        })}
                    </div>
                </div>
                <div className="wheel-fade" aria-hidden="true" />
            </div>

            {showResult && (
                <div className="wheel-result">
                    <p className="b3 wheel-result-label">
                        {props.playerName ? `${props.playerName}, тебе подходит` : 'Тебе подходит'}
                    </p>
                    <h3>{props.match.correct_profession.name}</h3>
                    {props.match.correct_profession.description && (
                        <p className="b2">{props.match.correct_profession.description}</p>
                    )}
                    <Button
                        text={relatedTest ? 'Пройти тест' : 'Смотреть тесты'}
                        onClick={() => navigate(relatedTest ? `/test/${relatedTest.code}` : '/test')}
                        classes={['but2', 'main-button']}
                    />
                </div>
            )}
        </div>
    )
}
