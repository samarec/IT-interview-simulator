export type TestSortMode = 'new' | 'popular'

export interface TopicTag {
    id: number
    name: string
}

export interface TopicData {
    id: number
    name: string
    code?: string | null
    tags: TopicTag[]
    cards_count: number
    completed_count: number
    passed_count: number
    description?: string | null
}

export async function fetchTopics(): Promise<TopicData[]> {
    const response = await fetch('/api/topics')
    if (!response.ok) {
        throw new Error('Не удалось загрузить тесты')
    }
    return response.json()
}

export function estimateTestMinutes(cardsCount: number): number {
    return Math.max(10, Math.round(cardsCount * 0.6))
}

export function uniqueTags(topics: TopicData[]): TopicTag[] {
    const tags = new Map<number, TopicTag>()
    topics.forEach((topic) => {
        topic.tags.forEach((tag) => {
            tags.set(tag.id, tag)
        })
    })
    return Array.from(tags.values())
}
