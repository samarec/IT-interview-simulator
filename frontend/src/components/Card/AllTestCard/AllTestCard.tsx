import './AllTestCard.css'

import { TestCard } from './Testcard'
import { estimateTestMinutes, type TopicData } from '../../../pages/testData'

export function AllTestCard(props: {
    topics: TopicData[]
    status: 'loading' | 'ready' | 'error'
}) {
    const showCards = props.status === 'ready' && props.topics.length > 0

    return (
        <section id="all-test-card">
            {props.status === 'loading' && (
                <p className="b2 test-status">Загружаем тесты…</p>
            )}
            {props.status === 'error' && (
                <p className="b2 test-status">Не удалось загрузить тесты. Попробуйте обновить страницу.</p>
            )}
            {props.status === 'ready' && props.topics.length === 0 && (
                <p className="b2 test-status">По выбранным фильтрам тесты не найдены.</p>
            )}
            {showCards && (
                <div className="single-test-card">
                    {props.topics.map((topic) => (
                        <TestCard
                            key={topic.id}
                            title={topic.name}
                            code={topic.code}
                            countQuestion={topic.cards_count}
                            timeMin={estimateTestMinutes(topic.cards_count)}
                            level={topic.tags[0]?.name ?? 'Тест'}
                            description={topic.description || `Тест по теме «${topic.name}». ${topic.cards_count} вопросов.`}
                            passedCount={topic.passed_count ?? 0}
                            tags={topic.tags}
                        />
                    ))}
                </div>
            )}
        </section>
    )
}
