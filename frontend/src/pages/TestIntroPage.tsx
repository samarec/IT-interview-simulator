import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'

import './TestSession.css'

import { fetchTest, type TestInfo } from '../api/tests'
import { Button } from '../components/Buttons/Button'
import { getSkillIcon } from '../data/skillIcons'

export function TestIntroPage() {
    const { code } = useParams<{ code: string }>()
    const navigate = useNavigate()
    const [test, setTest] = useState<TestInfo | null>(null)
    const [status, setStatus] = useState<'loading' | 'ready' | 'error'>('loading')

    useEffect(() => {
        if (!code) {
            setStatus('error')
            return
        }

        let cancelled = false
        setStatus('loading')

        fetchTest(code)
            .then((item) => {
                if (!cancelled) {
                    setTest(item)
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
    }, [code])

    if (status === 'loading') {
        return (
            <div className="test-session">
                <p className="b2 test-session-status">Загружаем тест…</p>
            </div>
        )
    }

    if (status === 'error' || !test || !code) {
        return (
            <div className="test-session">
                <p className="b2 test-session-status">Тест не найден.</p>
                <Button text="К списку тестов" onClick={() => navigate('/test')} classes={['but2', 'main-button']} />
            </div>
        )
    }

    const icon = getSkillIcon([], test.name)

    return (
        <div className="test-session test-intro">
            <p className="test-intro-label">Тест</p>
            <h1>{test.name}</h1>
            {icon && <img className="test-session-hero" src={icon} alt="" />}
            <div className="test-intro-stats">
                <div className="test-intro-stat gradient-wight-card-fill">
                    <strong>{test.cards_count}</strong>
                    <span>Вопросов</span>
                </div>
                <div className="test-intro-stat gradient-wight-card-fill">
                    <strong>{test.duration_minutes} минут</strong>
                    <span>Время прохождения</span>
                </div>
            </div>
            <p className="b2 test-intro-description">
                {test.description || `Тест по теме «${test.name}». Выберите режим и проверьте свои знания.`}
            </p>
            <div className="test-intro-actions">
                <Button
                    text="Тренировка"
                    onClick={() => navigate(`/test/${code}/training`)}
                    classes={['but1', 'main-button']}
                />
                <Button
                    text="Экзамен"
                    onClick={() => navigate(`/test/${code}/exam`)}
                    classes={['but1', 'main-button', 'main-button--orange']}
                />
            </div>
        </div>
    )
}
