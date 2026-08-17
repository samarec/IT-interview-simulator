import { useEffect, useMemo, useState } from 'react'

import './TestPage.css'

import { StatisticsTestCard } from '../components/Card/StatisticsTestCard/StatisticsTestCard'
import { CategoriesTestCard } from '../components/Card/CaregoriesTestCard/CategoriesTestCard'
import { AllTestCard } from '../components/Card/AllTestCard/AllTestCard'
import { fetchTopics, uniqueTags, type TestSortMode, type TopicData } from './testData'

export default function TestPage() {
    const [topics, setTopics] = useState<TopicData[]>([])
    const [status, setStatus] = useState<'loading' | 'ready' | 'error'>('loading')
    const [search, setSearch] = useState('')
    const [selectedTagId, setSelectedTagId] = useState<number | null>(null)
    const [sortMode, setSortMode] = useState<TestSortMode>('new')

    useEffect(() => {
        let cancelled = false

        fetchTopics()
            .then((items) => {
                if (cancelled) {
                    return
                }
                setTopics(items)
                setStatus('ready')
            })
            .catch(() => {
                if (!cancelled) {
                    setStatus('error')
                }
            })

        return () => {
            cancelled = true
        }
    }, [])

    const tags = useMemo(() => uniqueTags(topics), [topics])

    const filteredTopics = useMemo(() => {
        const query = search.trim().toLowerCase()

        const list = topics.filter((topic) => {
            const matchesSearch = !query || topic.name.toLowerCase().includes(query)
            const matchesTag = selectedTagId == null || topic.tags.some((tag) => tag.id === selectedTagId)
            return matchesSearch && matchesTag
        })

        return [...list].sort((a, b) => {
            if (sortMode === 'popular') {
                return b.cards_count - a.cards_count
            }
            return b.id - a.id
        })
    }, [topics, search, selectedTagId, sortMode])

    return (
        <div id="test-page">
            <StatisticsTestCard
                topics={topics}
                tagCount={tags.length}
                search={search}
                onSearchChange={setSearch}
            />
            <CategoriesTestCard
                tags={tags}
                selectedTagId={selectedTagId}
                onSelectTag={setSelectedTagId}
                sortMode={sortMode}
                onSortChange={setSortMode}
            />
            {/* recommendation-test-card временно скрыт */}
            <AllTestCard topics={filteredTopics} status={status} />
        </div>
    )
}
