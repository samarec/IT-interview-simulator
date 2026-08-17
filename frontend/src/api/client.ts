export class ApiError extends Error {
    status: number

    constructor(message: string, status: number) {
        super(message)
        this.status = status
    }
}

const ERROR_MESSAGES: Record<string, string> = {
    'Email already registered': 'Этот email уже зарегистрирован',
    'Username already taken': 'Это имя уже занято',
    'Incorrect email or password': 'Неверный email или пароль',
    'Could not validate credentials': 'Сессия истекла. Войдите снова',
}

function translateError(detail: unknown): string {
    if (typeof detail === 'string') {
        return ERROR_MESSAGES[detail] ?? detail
    }
    if (Array.isArray(detail) && detail[0]?.msg) {
        return 'Проверьте правильность заполнения полей'
    }
    return 'Не удалось выполнить запрос'
}

export async function apiRequest<T>(
    path: string,
    options: RequestInit & { token?: string | null } = {},
): Promise<T> {
    const { token, headers, ...rest } = options
    const requestHeaders = new Headers(headers)

    if (rest.body && !requestHeaders.has('Content-Type')) {
        requestHeaders.set('Content-Type', 'application/json')
    }
    if (token) {
        requestHeaders.set('Authorization', `Bearer ${token}`)
    }

    const response = await fetch(path, {
        ...rest,
        headers: requestHeaders,
    })

    if (!response.ok) {
        let detail: unknown
        try {
            const payload = await response.json()
            detail = payload.detail
        } catch {
            detail = null
        }
        throw new ApiError(translateError(detail), response.status)
    }

    if (response.status === 204) {
        return undefined as T
    }

    return response.json()
}
