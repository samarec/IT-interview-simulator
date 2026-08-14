import './CategoriesTestCard.css'
import {Button} from "../../Buttons/Button";

const categories = [
    "NEW", "Котики", "Зум", "led-подсветка", "Дошик", "Кофе", "Сникерс", "Энергетик", "Хабр",
    "Чипсы", "Пицца", "Макбук", "Монитор"
]

export function CategoriesTestCard() {
    return (
        <section id='categories-test-card'>
            <div id='categories-test-tabs'>
                {categories.map((button) => (
                    <Button text={button} classes={['form-button']} />
                ))}
            </div>
            <div id='categories-test-sort'>
                <img src='/assets/Icons/icon.svg' alt='' />
                <p className="b2">Новые</p>
                <p className="b2">Популярные</p>
            </div>
        </section>
    )
}
