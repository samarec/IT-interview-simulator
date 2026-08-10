import './HelloCard.css'

import {MainButton} from "../../Buttons/Button";

export function HelloCard() {
    return (
        <section id='hello-card'>
            <h1>Твой личный тренажер IT-собеседований</h1>
            <p>Пошаговая подготовка к техническим интервью
                в формате удобных билетов. Разбери свои слабые места до встречи с рекрутером.</p>
            <MainButton text="call to action" classes={["but1"]}/>
        </section>

    )
}