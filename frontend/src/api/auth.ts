import { apiRequest } from './client'

export interface User {
    id: number
    username: string
    email: string
    is_active: boolean
    role_id: number | null
}

interface TokenResponse {
    access_token: string
    token_type: string
}

export function getInitials(username: string): string {
    const parts = username.trim().split(/\s+/).filter(Boolean)
    if (parts.length >= 2) {
        return (parts[0][0] + parts[1][0]).toUpperCase()
    }
    return username.trim().slice(0, 2).toUpperCase() || '?'
}

export function registerUser(data: { username: string; email: string; password: string }) {
    return apiRequest<User>('/api/auth/register', {
        method: 'POST',
        body: JSON.stringify(data),
    })
}

export function loginUser(data: { email: string; password: string }) {
    return apiRequest<TokenResponse>('/api/auth/login', {
        method: 'POST',
        body: JSON.stringify(data),
    })
}

export function fetchCurrentUser(token: string) {
    return apiRequest<User>('/api/auth/me', { token })
}

export function updateCurrentUser(
    token: string,
    data: { username?: string; email?: string; password?: string },
) {
    return apiRequest<User>('/api/auth/me', {
        method: 'PATCH',
        token,
        body: JSON.stringify(data),
    })
}
