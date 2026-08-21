import './CategoriesTestCard.css'

import { Button } from '../../Buttons/Button'
import type { TopicTag } from '../../../pages/testData'

export function CategoriesTestCard(props: {
    tags: TopicTag[]
    selectedTagId: number | null
    onSelectTag: (tagId: number | null) => void
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
        </section>
    )
}
