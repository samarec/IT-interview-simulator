export interface FaqItemData {
    id: number
    title: string
    description: string
}

export async function fetchFaqs(): Promise<FaqItemData[]> {
    const response = await fetch('/api/topics/faq')
    if (!response.ok) {
        throw new Error('Не удалось загрузить FAQ')
    }
    return response.json()
}
