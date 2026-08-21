import { useEffect, useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'

import './ProfilePage.css'

import { fetchUserTests, type CompletedAttempt } from '../api/auth'
import { Button } from '../components/Buttons/Button'
import { Input } from '../components/Input/Input'
import { Tab } from '../components/Tabs/Tab'
import { UserAvatar } from '../components/UserAvatar/UserAvatar'
import { getSkillIcon } from '../data/skillIcons'
import { useAuth } from '../context/AuthContext'

type ProfileTab = 'training' | 'exam'

export function ProfilePage() {
    const navigate = useNavigate()
    const { user, token, isReady, updateProfile, logout } = useAuth()
    const [username, setUsername] = useState('')
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [error, setError] = useState('')
    const [success, setSuccess] = useState('')
    const [isSubmitting, setIsSubmitting] = useState(false)
    const [isEditing, setIsEditing] = useState(false)
    const [tab, setTab] = useState<ProfileTab>('training')
    const [attempts, setAttempts] = useState<CompletedAttempt[]>([])
    const [testsCompleted, setTestsCompleted] = useState(0)
    const [examsPassed, setExamsPassed] = useState(0)
    const [averagePercent, setAveragePercent] = useState(0)
    const [listStatus, setListStatus] = useState<'idle' | 'loading' | 'ready' | 'error'>('idle')

    useEffect(() => {
        if (isReady && !user) {
            navigate('/', { replace: true })
        }
    }, [isReady, user, navigate])

    useEffect(() => {
        if (!user) {
            return
        }
        setUsername(user.username)
        setEmail(user.email)
    }, [user])

    useEffect(() => {
        if (!token) {
            return
        }

        let cancelled = false
        setListStatus('loading')

        fetchUserTests(token)
            .then((overview) => {
                if (cancelled) {
                    return
                }
                setAttempts(overview.items)
                setTestsCompleted(overview.tests_completed)
                setExamsPassed(overview.exams_passed)
                setAveragePercent(overview.average_percent)
                setListStatus('ready')
            })
            .catch(() => {
                if (!cancelled) {
                    setListStatus('error')
                }
            })

        return () => {
            cancelled = true
        }
    }, [token])

    const visibleAttempts = useMemo(
        () => attempts.filter((item) => (tab === 'exam' ? item.mode === 'exam' : item.mode !== 'exam')),
        [attempts, tab],
    )

    async function handleUpdate() {
        setError('')
        setSuccess('')

        if (username.trim().length < 2) {
            setError('Введите имя — минимум 2 символа')
            return
        }
        if (!email.trim() || !email.includes('@')) {
            setError('Введите корректный email')
            return
        }
        if (password && password.length < 6) {
            setError('Новый пароль должен быть не короче 6 символов')
            return
        }

        setIsSubmitting(true)
        try {
            await updateProfile({
                username: username.trim(),
                email: email.trim(),
                password: password || undefined,
            })
            setPassword('')
            setSuccess('Данные обновлены')
            setIsEditing(false)
        } catch (updateError) {
            setError(updateError instanceof Error ? updateError.message : 'Не удалось обновить данные')
        } finally {
            setIsSubmitting(false)
        }
    }

    function handleLogout() {
        logout()
        navigate('/')
    }

    if (!isReady || !user) {
        return null
    }

    return (
        <div id="profile-page">
            <div className="background-container">
                <section id="profile-content">
                    <aside className="profile-avatar-side">
                        <UserAvatar username={user.username} size="profile" />
                        <p className="profile-avatar-name">{user.username}</p>
                        <div className="profile-side-actions">
                            <Button
                                text={isEditing ? 'Закрыть' : 'Редактировать'}
                                onClick={() => {
                                    setIsEditing((current) => !current)
                                    setError('')
                                    setSuccess('')
                                    setPassword('')
                                    if (user) {
                                        setUsername(user.username)
                                        setEmail(user.email)
                                    }
                                }}
                                classes={['but2', 'main-button', 'main-button--orange']}
                            />
                            <Button
                                text="Выйти"
                                onClick={handleLogout}
                                classes={['but2', 'main-button', 'main-button--light']}
                            />
                        </div>
                    </aside>

                    <div className="profile-main">
                        {isEditing ? (
                            <form
                                className="profile-form gradient-wight-card-fill"
                                onSubmit={(event) => {
                                    event.preventDefault()
                                    void handleUpdate()
                                }}
                            >
                                <h2>Обновить данные</h2>
                                <div className="profile-form-fields">
                                    <Input
                                        text="Имя"
                                        name="username"
                                        autoComplete="username"
                                        value={username}
                                        onChange={setUsername}
                                        disabled={isSubmitting}
                                    />
                                    <Input
                                        text="Email"
                                        type="email"
                                        name="email"
                                        autoComplete="email"
                                        value={email}
                                        onChange={setEmail}
                                        disabled={isSubmitting}
                                    />
                                    <Input
                                        text="Новый пароль"
                                        type="password"
                                        name="password"
                                        autoComplete="new-password"
                                        value={password}
                                        onChange={setPassword}
                                        disabled={isSubmitting}
                                    />
                                </div>
                                {error && <p className="profile-form-error b3">{error}</p>}
                                {success && <p className="profile-form-success b3">{success}</p>}
                                <Button
                                    text={isSubmitting ? 'Сохраняем…' : 'Сохранить'}
                                    type="submit"
                                    disabled={isSubmitting}
                                    classes={['but1', 'main-button']}
                                />
                            </form>
                        ) : (
                            <>
                        <div className="profile-stats">
                            <div className="profile-stat gradient-wight-card-fill">
                                <strong>{testsCompleted}</strong>
                                <span>Тестов пройдено</span>
                            </div>
                            <div className="profile-stat gradient-wight-card-fill">
                                <strong>{examsPassed}</strong>
                                <span>Экзаменов сдано</span>
                            </div>
                            <div className="profile-stat gradient-wight-card-fill">
                                <strong>{averagePercent}%</strong>
                                <span>Средний результат</span>
                            </div>
                        </div>

                        <div className="profile-tabs">
                            <button
                                type="button"
                                className={`profile-tab${tab === 'training' ? ' profile-tab--active' : ''}`}
                                onClick={() => setTab('training')}
                            >
                                Тесты
                            </button>
                            <button
                                type="button"
                                className={`profile-tab${tab === 'exam' ? ' profile-tab--active' : ''}`}
                                onClick={() => setTab('exam')}
                            >
                                Экзамены
                            </button>
                        </div>

                        {listStatus === 'error' && (
                            <p className="b2 profile-tests-status">
                                Не удалось загрузить пройденные тесты.
                            </p>
                        )}

                        {listStatus === 'ready' && visibleAttempts.length === 0 && (
                            <p className="b2 profile-tests-status">
                                {tab === 'exam'
                                    ? 'Пока нет сданных экзаменов. Пройдите тест в режиме экзамена.'
                                    : 'Пока нет пройденных тестов. Выберите тест и попробуйте свои силы.'}
                            </p>
                        )}

                        {listStatus === 'ready' && visibleAttempts.length > 0 && (
                            <div className="profile-tests-list">
                                {visibleAttempts.map((item) => {
                                    const icon = getSkillIcon(item.tags, item.test_name)
                                    const href = item.test_code
                                        ? `/test/${item.test_code}/${tab === 'exam' ? 'exam' : 'training'}`
                                        : '/test'
                                    return (
                                        <article className="profile-result-wrap" key={item.id}>
                                            <div className="profile-result-card gradient-wight-card-fill">
                                                <span className={`profile-result-badge${item.passed ? '' : ' profile-result-badge--fail'}`}>
                                                    {item.passed ? 'Пройден' : 'Не сдан'}
                                                </span>
                                                <h3>{item.test_name}</h3>
                                                <div className="profile-result-tabs">
                                                    <Tab
                                                        text={`${item.cards_count} вопросов`}
                                                        icon="/assets/Icons/iconQuestion.svg"
                                                    />
                                                    <Tab
                                                        text={`${item.duration_minutes} минут`}
                                                        icon="/assets/Icons/iconClock.svg"
                                                    />
                                                </div>
                                                <div className="profile-result-footer">
                                                    <Button
                                                        text="Повторить"
                                                        onClick={() => navigate(href)}
                                                        classes={['but2', 'main-button']}
                                                    />
                                                    <div className="profile-result-score">
                                                        <strong>
                                                            {item.score ?? 0}/{item.max_score ?? item.cards_count}
                                                        </strong>
                                                        <span>Правильных ответов</span>
                                                    </div>
                                                </div>
                                            </div>
                                            {icon && <img className="profile-result-skill" src={icon} alt="" />}
                                        </article>
                                    )
                                })}
                            </div>
                        )}
                            </>
                        )}
                    </div>
                </section>
            </div>
        </div>
    )
}
