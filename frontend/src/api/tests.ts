import { apiRequest } from './client'

export type TestMode = 'training' | 'exam'

export interface TestInfo {
    id: number
    name: string
    code: string
    description?: string | null
    duration_minutes: number
    cards_count: number
    profession_id?: number | null
}

export interface TestAnswer {
    id: number
    title: string
    is_correct?: boolean | null
}

export interface TestCard {
    id: number
    topic_id: number
    title: string
    description?: string | null
    answers: TestAnswer[]
}

export interface TestDetail extends TestInfo {
    cards: TestCard[]
}

export interface TestSubmitResult {
    test: TestInfo
    correct_count: number
    total: number
    passed: boolean
    results: Array<{
        card_id: number
        selected_answer_id: number | null
        correct_answer_id: number | null
        is_correct: boolean
    }>
}

export function fetchTest(code: string) {
    return apiRequest<TestInfo>(`/api/tests/${code}`)
}

export function fetchTestCards(code: string, mode: TestMode) {
    return apiRequest<TestDetail>(`/api/tests/${code}/cards?mode=${mode}`)
}

export function submitTest(
    code: string,
    answers: Array<{ card_id: number; answer_id: number }>,
    token?: string | null,
) {
    return apiRequest<TestSubmitResult>(`/api/tests/${code}/submit`, {
        method: 'POST',
        token,
        body: JSON.stringify({ answers }),
    })
}
