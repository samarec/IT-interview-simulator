import './StatisticsTestCard.css'

import { Search } from '../../Input/Search'
import type { TestInfo } from '../../../api/tests'
import type { TestSortMode } from '../../../pages/testData'

export function StatisticsTestCard(props: {
    tests: TestInfo[]
    tagCount: number
    search: string
    onSearchChange: (value: string) => void
    sortMode: TestSortMode
    onSortChange: (mode: TestSortMode) => void
}) {
    const questionCount = props.tests.reduce((sum, test) => sum + test.cards_count, 0)
    const tabs = [
        { text: 'Вопросы', value: String(questionCount) },
        { text: 'Темы', value: String(props.tagCount) },
        { text: 'Тесты', value: String(props.tests.length) },
    ]

    return (
        <section id="statistics-test-card">
            <div id="statistics-test" className="gradient-wight-card-fill">
                <h1>Тесты</h1>
                <div id="statistics-test-tabs">
                    {tabs.map((tab) => (
                        <div key={tab.text} className="statistics-test-tab">
                            <p>{tab.text}</p>
                            <h3>{tab.value}</h3>
                        </div>
                    ))}
                </div>
            </div>
            <div id="statistics-test-search">
                <Search text="Поиск" value={props.search} onChange={props.onSearchChange} />
                <div id="categories-test-sort">
                    <button
                        type="button"
                        className={`test-sort-label${props.sortMode === 'new' ? ' sort-active' : ''}`}
                        onClick={() => props.onSortChange('new')}
                    >
                        Новые
                    </button>
                    <button
                        type="button"
                        className={`test-sort-label${props.sortMode === 'popular' ? ' sort-active' : ''}`}
                        onClick={() => props.onSortChange('popular')}
                    >
                        Популярные
                    </button>
                </div>
            </div>
            <img id="pill1-background-statistics-test" className="part" src="/assets/Pill1.png" alt="" />
            <img id="sphere-background-statistics-test" className="part" src="/assets/Sphere.png" alt="" />
            <img id="thorus-knot-background-statistics-test" className="part" src="/assets/ThorusKnot.png" alt="" />
            <img id="helix-background-statistics-test" className="part" src="/assets/Helix.png" alt="" />
            <img id="group3-background-statistics-test" className="part" src="/assets/Group3.svg" alt="" />
        </section>
    )
}
