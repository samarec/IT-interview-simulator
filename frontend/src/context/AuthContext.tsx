import { createContext, useContext, useEffect, useMemo, useState, type ReactNode } from 'react'

import { ApiError } from '../api/client'
import {
    fetchCurrentUser,
    loginUser,
    registerUser,
    updateCurrentUser,
    type User,
} from '../api/auth'

const TOKEN_KEY = 'saby_access_token'

interface AuthContextValue {
    user: User | null
    token: string | null
    isReady: boolean
    login: (email: string, password: string) => Promise<void>
    register: (username: string, email: string, password: string) => Promise<void>
    updateProfile: (data: { username: string; email: string; password?: string }) => Promise<void>
    logout: () => void
}

const AuthContext = createContext<AuthContextValue | null>(null)

export function AuthProvider(props: { children: ReactNode }) {
    const [user, setUser] = useState<User | null>(null)
    const [token, setToken] = useState<string | null>(null)
    const [isReady, setIsReady] = useState(false)

    useEffect(() => {
        const storedToken = localStorage.getItem(TOKEN_KEY)
        if (!storedToken) {
            setIsReady(true)
            return
        }

        fetchCurrentUser(storedToken)
            .then((currentUser) => {
                setToken(storedToken)
                setUser(currentUser)
            })
            .catch((error) => {
                if (error instanceof ApiError && error.status === 401) {
                    localStorage.removeItem(TOKEN_KEY)
                }
            })
            .finally(() => {
                setIsReady(true)
            })
    }, [])

    async function persistSession(accessToken: string) {
        const currentUser = await fetchCurrentUser(accessToken)
        localStorage.setItem(TOKEN_KEY, accessToken)
        setToken(accessToken)
        setUser(currentUser)
    }

    const value = useMemo<AuthContextValue>(() => ({
        user,
        token,
        isReady,
        async login(email, password) {
            const response = await loginUser({ email, password })
            await persistSession(response.access_token)
        },
        async register(username, email, password) {
            await registerUser({ username, email, password })
            const response = await loginUser({ email, password })
            await persistSession(response.access_token)
        },
        async updateProfile(data) {
            if (!token) {
                throw new Error('Нужно войти в аккаунт')
            }
            const payload = data.password
                ? data
                : { username: data.username, email: data.email }
            const updatedUser = await updateCurrentUser(token, payload)
            setUser(updatedUser)
        },
        logout() {
            localStorage.removeItem(TOKEN_KEY)
            setToken(null)
            setUser(null)
        },
    }), [user, token, isReady])

    return (
        <AuthContext.Provider value={value}>
            {props.children}
        </AuthContext.Provider>
    )
}

export function useAuth() {
    const context = useContext(AuthContext)
    if (!context) {
        throw new Error('useAuth должен использоваться внутри AuthProvider')
    }
    return context
}
