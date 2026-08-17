import { useEffect, useState } from 'react'
import { Link, useLocation, useNavigate } from 'react-router-dom'

import './Header.css'

import { Button } from '../Buttons/Button'
import { AuthModal } from '../Modal/AuthModal'
import { UserAvatar } from '../UserAvatar/UserAvatar'
import { useAuth } from '../../context/AuthContext'
import { navItems } from './headerData'

export default function Header() {
    const navigate = useNavigate()
    const location = useLocation()
    const { user, isReady } = useAuth()
    const [isAuthOpen, setIsAuthOpen] = useState(false)
    const [isMenuOpen, setIsMenuOpen] = useState(false)

    useEffect(() => {
        setIsMenuOpen(false)
    }, [location.pathname])

    useEffect(() => {
        function onResize() {
            if (window.innerWidth > 880) {
                setIsMenuOpen(false)
            }
        }

        function onKeyDown(event: KeyboardEvent) {
            if (event.key === 'Escape') {
                setIsMenuOpen(false)
            }
        }

        window.addEventListener('resize', onResize)
        window.addEventListener('keydown', onKeyDown)
        return () => {
            window.removeEventListener('resize', onResize)
            window.removeEventListener('keydown', onKeyDown)
        }
    }, [])

    useEffect(() => {
        if (!isMenuOpen) {
            return
        }

        const previousOverflow = document.body.style.overflow
        document.body.style.overflow = 'hidden'
        return () => {
            document.body.style.overflow = previousOverflow
        }
    }, [isMenuOpen])

    function goTo(href: string) {
        setIsMenuOpen(false)
        navigate(href)
    }

    return (
        <header className={`header${isMenuOpen ? ' header--menu-open' : ''}`}>
            <div className="header-bar">
                <Link to="/" className="header-logo" onClick={() => setIsMenuOpen(false)}>
                    <img src="/assets/LogoBird.svg" alt="" width={22} height={30} />
                    <span className="header-logo-text">
                        <span>saby</span> практика
                    </span>
                </Link>

                <nav id="header-nav" className={`nav${isMenuOpen ? ' nav--open' : ''}`}>
                    {navItems.map((item) => (
                        <Button
                            key={item.id}
                            text={item.title}
                            onClick={() => goTo(item.href)}
                            classes={[
                                'menu-button',
                                location.pathname === item.href
                                    || (item.href !== '/' && location.pathname.startsWith(item.href))
                                    ? 'menu-button-active'
                                    : '',
                            ]}
                        />
                    ))}
                </nav>

                <button
                    type="button"
                    className="header-menu-toggle"
                    aria-label={isMenuOpen ? 'Закрыть меню' : 'Открыть меню'}
                    aria-expanded={isMenuOpen}
                    aria-controls="header-nav"
                    onClick={() => setIsMenuOpen((open) => !open)}
                >
                    <span />
                    <span />
                    <span />
                </button>
            </div>

            {!isReady ? (
                <div className="header-user-placeholder" />
            ) : user ? (
                <Link to="/profile" className="header-user" onClick={() => setIsMenuOpen(false)}>
                    <UserAvatar username={user.username} />
                    <span className="header-user-name">{user.username}</span>
                </Link>
            ) : (
                <Button
                    text="Войти"
                    onClick={() => {
                        setIsMenuOpen(false)
                        setIsAuthOpen(true)
                    }}
                    classes={['but2', 'main-button', 'header-login']}
                />
            )}

            {isMenuOpen && (
                <button
                    type="button"
                    className="header-menu-backdrop"
                    aria-label="Закрыть меню"
                    onClick={() => setIsMenuOpen(false)}
                />
            )}

            {isAuthOpen && <AuthModal onClose={() => setIsAuthOpen(false)} />}
        </header>
    )
}
