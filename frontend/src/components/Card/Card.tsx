import './Card.css';

import { MainButton } from '../Button/MainButton';

import { AdvantageCard } from "./AdvantagCard/AdvantageCard";
import { advantagesCard } from "./AdvantagCard/dataAdvantageCard";

export function HelloCard() {
    return (
        <section id='hello-card'>
            <h1>Твой личный тренажер IT-собеседований</h1>
            <p>Пошаговая подготовка к техническим интервью
                в формате удобных билетов. Разбери свои слабые места до встречи с рекрутером.</p>
            <MainButton text={"call to action"} />
        </section>

    )
}

export function AdvantagesCard() {
    return (
        <section id='advantages-card'>
            {advantagesCard.map((advantage) => (
                <AdvantageCard id={advantage.id} title={advantage.title} description={advantage.description} />
            ))}
        </section>
    );
}
