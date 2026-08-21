import { useEffect, useState } from 'react'
import { createPortal } from 'react-dom'

import './AuthModal.css'

import { Button } from '../Buttons/Button'
import { Input } from '../Input/Input'
import { useAuth } from '../../context/AuthContext'

type AuthTab = 'login' | 'register'

export function AuthModal(props: { onClose: () => void }) {
    const { login, register } = useAuth()
    const [tab, setTab] = useState<AuthTab>('register')
    const [username, setUsername] = useState('')
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [error, setError] = useState('')
    const [isSubmitting, setIsSubmitting] = useState(false)

    useEffect(() => {
        function onKeyDown(event: KeyboardEvent) {
            if (event.key === 'Escape') {
                props.onClose()
            }
        }

        const previousOverflow = document.body.style.overflow
        document.body.style.overflow = 'hidden'
        window.addEventListener('keydown', onKeyDown)

        return () => {
            document.body.style.overflow = previousOverflow
            window.removeEventListener('keydown', onKeyDown)
        }
    }, [props])

    function resetForm() {
        setUsername('')
        setEmail('')
        setPassword('')
        setError('')
    }

    function switchTab(nextTab: AuthTab) {
        setTab(nextTab)
        resetForm()
    }

    async function handleSubmit() {
        setError('')

        if (tab === 'register' && username.trim().length < 2) {
            setError('Введите имя — минимум 2 символа')
            return
        }
        if (!email.trim() || !email.includes('@')) {
            setError('Введите корректный email')
            return
        }
        if (password.length < 6) {
            setError('Пароль должен быть не короче 6 символов')
            return
        }
        if (password.length > 72) {
            setError('Пароль слишком длинный')
            return
        }

        setIsSubmitting(true)
        try {
            if (tab === 'register') {
                await register(username.trim(), email.trim(), password)
            } else {
                await login(email.trim(), password)
            }
            props.onClose()
        } catch (submitError) {
            setError(submitError instanceof Error ? submitError.message : 'Не удалось выполнить запрос')
        } finally {
            setIsSubmitting(false)
        }
    }

    return createPortal(
        <div className="auth-modal-overlay" onClick={props.onClose}>
            <div
                className="auth-modal"
                role="dialog"
                aria-modal="true"
                aria-labelledby="auth-modal-title"
                onClick={(event) => event.stopPropagation()}
            >
                <button
                    type="button"
                    className="auth-modal-close"
                    aria-label="Закрыть"
                    onClick={props.onClose}
                />

                <div className="auth-modal-intro">
                    <h2 id="auth-modal-title">
                        {tab === 'register' ? 'Регистрация' : 'Вход'}
                    </h2>
                    <p className="b3">
                        {tab === 'register'
                            ? 'Создай аккаунт, чтобы сохранять прогресс по тестам и открыть личный кабинет. После регистрации в шапке появятся твои инициалы и имя.'
                            : 'Войди в аккаунт, чтобы продолжить подготовку и видеть пройденные тесты в личном кабинете.'}
                    </p>
                </div>

                <div className="auth-modal-tabs">
                    <Button
                        text="Регистрация"
                        onClick={() => switchTab('register')}
                        classes={['menu-button', tab === 'register' ? 'menu-button-active' : '']}
                    />
                    <Button
                        text="Вход"
                        onClick={() => switchTab('login')}
                        classes={['menu-button', tab === 'login' ? 'menu-button-active' : '']}
                    />
                </div>

                <form
                    className="auth-modal-form"
                    onSubmit={(event) => {
                        event.preventDefault()
                        void handleSubmit()
                    }}
                >
                    {tab === 'register' && (
                        <Input
                            text="Имя"
                            name="username"
                            autoComplete="username"
                            value={username}
                            onChange={setUsername}
                            disabled={isSubmitting}
                        />
                    )}
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
                        text="Пароль"
                        type="password"
                        name="password"
                        autoComplete={tab === 'register' ? 'new-password' : 'current-password'}
                        value={password}
                        onChange={setPassword}
                        disabled={isSubmitting}
                    />

                    {error && <p className="auth-modal-error b3">{error}</p>}

                    <Button
                        text={isSubmitting
                            ? 'Сохраняем…'
                            : tab === 'register' ? 'Зарегистрироваться' : 'Войти'}
                        type="submit"
                        disabled={isSubmitting}
                        classes={['but1', 'main-button']}
                    />
                </form>
            </div>
        </div>,
        document.body,
    )
}
