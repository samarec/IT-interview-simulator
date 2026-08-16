import { useState } from 'react'
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

    return (
        <header className="header">
            <div className="header-bar">
                <Link to="/" className="header-logo">
                    <img src="/assets/LogoBird.svg" alt="" width={22} height={30} />
                    <span className="header-logo-text">
                        <span>saby</span> практика
                    </span>
                </Link>

                <nav className="nav">
                    {navItems.map((item) => (
                        <Button
                            key={item.id}
                            text={item.title}
                            onClick={() => navigate(item.href)}
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
            </div>

            {!isReady ? (
                <div className="header-user-placeholder" />
            ) : user ? (
                <Link to="/profile" className="header-user">
                    <UserAvatar username={user.username} />
                    <span className="header-user-name">{user.username}</span>
                </Link>
            ) : (
                <Button
                    text="Войти"
                    onClick={() => setIsAuthOpen(true)}
                    classes={['but2', 'main-button', 'header-login']}
                />
            )}

            {isAuthOpen && <AuthModal onClose={() => setIsAuthOpen(false)} />}
        </header>
    )
}
