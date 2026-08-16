import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'

import './ProfilePage.css'

import { fetchTopics, type Topic } from '../api/topics'
import { Button } from '../components/Buttons/Button'
import { Input } from '../components/Input/Input'
import { Tab } from '../components/Tabs/Tab'
import { UserAvatar } from '../components/UserAvatar/UserAvatar'
import { useAuth } from '../context/AuthContext'

export function ProfilePage() {
    const navigate = useNavigate()
    const { user, token, isReady, updateProfile, logout } = useAuth()
    const [username, setUsername] = useState('')
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [error, setError] = useState('')
    const [success, setSuccess] = useState('')
    const [isSubmitting, setIsSubmitting] = useState(false)
    const [completedTopics, setCompletedTopics] = useState<Topic[]>([])
    const [topicsStatus, setTopicsStatus] = useState<'idle' | 'loading' | 'ready' | 'error'>('idle')

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
        setTopicsStatus('loading')

        fetchTopics(token)
            .then((topics) => {
                if (cancelled) {
                    return
                }
                setCompletedTopics(topics.filter((topic) => topic.completed_count > 0))
                setTopicsStatus('ready')
            })
            .catch(() => {
                if (!cancelled) {
                    setTopicsStatus('error')
                }
            })

        return () => {
            cancelled = true
        }
    }, [token])

    async function handleUpdate() {
        setError('')
        setSuccess('')

        if (username.trim().length < 2) {
            setError('Введите имя — минимум 2 символа')
            return
        }
        if (!email.trim()) {
            setError('Введите email')
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
                        <div className="profile-intro">
                            <h1>Личный кабинет</h1>
                            <p className="b2">
                                Обнови данные профиля и посмотри, какие тесты уже пройдены.
                            </p>
                        </div>

                        <div className="profile-data">
                            <div className="profile-avatar-side">
                                <UserAvatar username={user.username} size="profile" />
                                <p className="profile-avatar-name">{user.username}</p>
                                <Button
                                    text="Выйти"
                                    onClick={handleLogout}
                                    classes={['but2', 'main-button', 'main-button--orange']}
                                />
                            </div>

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
                                    text={isSubmitting ? 'Сохраняем…' : 'Обновить данные'}
                                    type="submit"
                                    disabled={isSubmitting}
                                    classes={['but1', 'main-button']}
                                />
                            </form>
                        </div>

                        {topicsStatus === 'error' && (
                            <p className="b2 profile-tests-status">
                                Не удалось загрузить пройденные тесты.
                            </p>
                        )}

                        {topicsStatus === 'ready' && completedTopics.length > 0 && (
                            <div className="profile-tests">
                                <h2>Пройденные тесты</h2>
                                <div className="profile-tests-list">
                                    {completedTopics.map((topic) => (
                                        <article
                                            key={topic.id}
                                            className="profile-test-card gradient-wight-card-fill"
                                        >
                                            <h3>{topic.name}</h3>
                                            <div className="profile-test-tabs">
                                                <Tab
                                                    text={`${topic.cards_count} вопросов`}
                                                    icon="/assets/Icons/iconQuestion.svg"
                                                />
                                                <Tab text={`Пройдено ${topic.completed_count} раз`} />
                                                {topic.tags.slice(0, 2).map((tag) => (
                                                    <Tab key={tag.id} text={tag.name} />
                                                ))}
                                            </div>
                                            <Button
                                                text="Пройти ещё"
                                                onClick={() => navigate(topic.code ? `/test/${topic.code}` : '/test')}
                                                classes={['but2', 'main-button']}
                                            />
                                        </article>
                                    ))}
                                </div>
                            </div>
                        )}
                    </section>
                </div>
        </div>
    )
}
