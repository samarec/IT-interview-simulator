import { apiRequest } from './client'

export interface Profession {
    id: number
    name: string
    description?: string | null
    tags?: Array<{ id: number; name: string }>
}

export interface ProfessionMatchResult {
    correct_profession: Profession
    wheel_professions: Profession[]
}

export function matchProfession(tagIds: number[]) {
    return apiRequest<ProfessionMatchResult>('/api/professions/match', {
        method: 'POST',
        body: JSON.stringify({ tag_ids: tagIds }),
    })
}
