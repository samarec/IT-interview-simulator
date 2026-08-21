import './AllTestCard.css'

import { TestCard } from './Testcard'
import type { TestInfo } from '../../../api/tests'

export function AllTestCard(props: {
    tests: TestInfo[]
    status: 'loading' | 'ready' | 'error'
}) {
    const showCards = props.status === 'ready' && props.tests.length > 0

    return (
        <section id="all-test-card">
            {props.status === 'loading' && (
                <p className="b2 test-status">Загружаем тесты…</p>
            )}
            {props.status === 'error' && (
                <p className="b2 test-status">Не удалось загрузить тесты. Попробуйте обновить страницу.</p>
            )}
            {props.status === 'ready' && props.tests.length === 0 && (
                <p className="b2 test-status">По выбранным фильтрам тесты не найдены.</p>
            )}
            {showCards && (
                <div className="single-test-card">
                    {props.tests.map((test) => (
                        <TestCard
                            key={test.id}
                            title={test.name}
                            code={test.code}
                            countQuestion={test.cards_count}
                            timeMin={test.duration_minutes}
                            level={(test.tags ?? [])[0]?.name ?? 'Тест'}
                            description={test.description || `Тест по теме «${test.name}». ${test.cards_count} вопросов.`}
                            passedCount={test.passed_count ?? 0}
                            tags={test.tags ?? []}
                        />
                    ))}
                </div>
            )}
        </section>
    )
}
