import { apiRequest } from './client'

export interface TopicTag {
    id: number
    name: string
}

export interface Topic {
    id: number
    name: string
    code?: string | null
    tags: TopicTag[]
    cards_count: number
    completed_count: number
    passed_count: number
}

export function fetchTopics(token?: string | null) {
    return apiRequest<Topic[]>('/api/topics', { token })
}
