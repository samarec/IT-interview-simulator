import './CategoriesTestCard.css'

import { Button } from '../../Buttons/Button'
import type { TestSortMode, TopicTag } from '../../../pages/testData'

export function CategoriesTestCard(props: {
    tags: TopicTag[]
    selectedTagId: number | null
    onSelectTag: (tagId: number | null) => void
    sortMode: TestSortMode
    onSortChange: (mode: TestSortMode) => void
}) {
    return (
        <section id="categories-test-card">
            <div id="categories-test-tabs">
                {props.tags.map((tag) => (
                    <Button
                        key={tag.id}
                        text={tag.name}
                        onClick={() => props.onSelectTag(props.selectedTagId === tag.id ? null : tag.id)}
                        classes={[
                            'form-button',
                            props.selectedTagId === tag.id ? 'form-button--selected' : '',
                        ]}
                    />
                ))}
            </div>
            <div id="categories-test-sort">
                <img src="/assets/Icons/icon.svg" alt="" />
                <button
                    type="button"
                    className={`b2${props.sortMode === 'new' ? ' sort-active' : ''}`}
                    onClick={() => props.onSortChange('new')}
                >
                    Новые
                </button>
                <button
                    type="button"
                    className={`b2${props.sortMode === 'popular' ? ' sort-active' : ''}`}
                    onClick={() => props.onSortChange('popular')}
                >
                    Популярные
                </button>
            </div>
        </section>
    )
}
