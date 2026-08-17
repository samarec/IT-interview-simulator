import './RecommendationTestCard.css'
import { useNavigate } from 'react-router-dom'

import { Button } from '../../Buttons/Button'
import { Tab } from '../../Tabs/Tab'
import type { TopicData } from '../../../pages/testData'

export function RecommendationTestCard(props: { topic: TopicData }) {
    const navigate = useNavigate()
    const { topic } = props
    const description = topic.description
        || `Тест по теме «${topic.name}». ${topic.cards_count} вопросов.`
    const href = topic.code ? `/test/${topic.code}` : '/test'

    return (
        <section id="recommendation-test-card">
            <h2>Рекомендуем пройти</h2>
            <div>
                <div id="recommendation-test-info">
                    <div>
                        <h3>{topic.name}</h3>
                        <div id="recommendation-test-tabs">
                            {topic.tags.map((tag) => (
                                <Tab key={tag.id} text={tag.name} />
                            ))}
                        </div>
                        <p className="b3">{description}</p>
                    </div>
                    <div className="recommendation-test-footer">
                        <Button
                            text="Пройти тест"
                            onClick={() => navigate(href)}
                            classes={['but2', 'main-button']}
                        />
                        <div className="test-card-passed">
                            <img src="/assets/Icons/iconUser.svg" alt="" />
                            <span className="b3">{topic.passed_count ?? 0}</span>
                        </div>
                    </div>
                </div>
                <div id="recommendation-test-image" />
            </div>
        </section>
    )
}
