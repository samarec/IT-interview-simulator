import { useEffect, useMemo, useState } from 'react'

import './TestPage.css'

import { StatisticsTestCard } from '../components/Card/StatisticsTestCard/StatisticsTestCard'
import { CategoriesTestCard } from '../components/Card/CaregoriesTestCard/CategoriesTestCard'
import { AllTestCard } from '../components/Card/AllTestCard/AllTestCard'
import { fetchTests, type TestInfo } from '../api/tests'
import { primaryTags, type TestSortMode } from './testData'

export default function TestPage() {
    const [tests, setTests] = useState<TestInfo[]>([])
    const [status, setStatus] = useState<'loading' | 'ready' | 'error'>('loading')
    const [search, setSearch] = useState('')
    const [selectedTagId, setSelectedTagId] = useState<number | null>(null)
    const [sortMode, setSortMode] = useState<TestSortMode>('new')

    useEffect(() => {
        let cancelled = false

        fetchTests()
            .then((items) => {
                if (cancelled) {
                    return
                }
                setTests(items.filter((test) => test.cards_count > 0))
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

    const tags = useMemo(() => primaryTags(tests), [tests])

    const filteredTests = useMemo(() => {
        const query = search.trim().toLowerCase()

        const list = tests.filter((test) => {
            const matchesSearch = !query
                || test.name.toLowerCase().includes(query)
                || (test.description ?? '').toLowerCase().includes(query)
            const matchesTag = selectedTagId == null
                || (test.tags ?? [])[0]?.id === selectedTagId
            return matchesSearch && matchesTag
        })

        return [...list].sort((a, b) => {
            if (sortMode === 'popular') {
                return b.passed_count - a.passed_count
            }
            return b.id - a.id
        })
    }, [tests, search, selectedTagId, sortMode])

    return (
        <div id="test-page">
            <StatisticsTestCard
                tests={tests}
                tagCount={tags.length}
                search={search}
                onSearchChange={setSearch}
                sortMode={sortMode}
                onSortChange={setSortMode}
            />
            <CategoriesTestCard
                tags={tags}
                selectedTagId={selectedTagId}
                onSelectTag={setSelectedTagId}
            />
            {/* recommendation-test-card временно скрыт */}
            <AllTestCard tests={filteredTests} status={status} />
        </div>
    )
}
