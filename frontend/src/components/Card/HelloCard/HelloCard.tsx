import './HelloCard.css'

import {Button} from "../../Buttons/Button";

export function HelloCard() {
    return (
        <section id='hello-card'>
            <h1>Твой личный тренажер IT-собеседований</h1>
            <p>Пошаговая подготовка к техническим интервью
                в формате удобных билетов. Разбери свои слабые места до встречи с рекрутером.</p>
            <Button text="Подобрать профессию" classes={["but1", "main-button"]}/>
        </section>

    )
}