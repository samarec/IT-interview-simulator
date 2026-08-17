import './StatisticsTestCard.css'

import { Search } from '../../Input/Search'
import type { TopicData } from '../../../pages/testData'

export function StatisticsTestCard(props: {
    topics: TopicData[]
    tagCount: number
    search: string
    onSearchChange: (value: string) => void
}) {
    const questionCount = props.topics.reduce((sum, topic) => sum + topic.cards_count, 0)
    const tabs = [
        { text: 'Вопросы', value: String(questionCount) },
        { text: 'Темы', value: String(props.tagCount) },
        { text: 'Тесты', value: String(props.topics.length) },
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
            </div>
            <img id="pill1-background-statistics-test" className="part" src="/assets/Pill1.png" alt="" />
            <img id="sphere-background-statistics-test" className="part" src="/assets/Sphere.png" alt="" />
            <img id="thorus-knot-background-statistics-test" className="part" src="/assets/ThorusKnot.png" alt="" />
            <img id="helix-background-statistics-test" className="part" src="/assets/Helix.png" alt="" />
            <img id="group3-background-statistics-test" className="part" src="/assets/Group3.svg" alt="" />
        </section>
    )
}
