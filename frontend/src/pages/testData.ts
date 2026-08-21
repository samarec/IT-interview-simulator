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

export function primaryTags(items: Array<{ tags?: TopicTag[] }>): TopicTag[] {
    const tags = new Map<number, TopicTag>()
    items.forEach((item) => {
        const tag = item.tags?.[0]
        if (tag) {
            tags.set(tag.id, tag)
        }
    })
    return Array.from(tags.values())
}
