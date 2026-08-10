import './Card.css';

import { MainButton } from '../Button/MainButton';
import { FromButton } from "../Button/FormButton";
import { Input } from "../Input/Input";
import { LearnImage } from "../Images/LearnImage";
import { ExamImage } from "../Images/ExamImage";

import { AdvantageCard } from "./AdvantagCard/AdvantageCard";
import { advantagesCard } from "./AdvantagCard/dataAdvantageCard";



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

export function AdvantagesCard() {
    return (
        <section id='advantages-card'>
            {advantagesCard.map((advantage) => (
                <AdvantageCard id={advantage.id} title={advantage.title} description={advantage.description} />
            ))}
        </section>
    );
}

export function TrialCard() {
    return (
        <section id='trial-card'>
            <h2>Готов попробовать прямо сейчас?</h2>
            <div>
                <div id="trial-qr">
                    <div>
                        {/*qr-code*/}
                    </div>
                    <p className="b2">Наведи камеру и ворвись в интерактив</p>
                </div>
                <p className="b2">Сканируй QR-код камерой телефона, запускай тренажер и проверь свои силы в режиме реального времени.
                    Никаких долгих регистраций — сразу к делу!</p>
            </div>
        </section>
    )
}

export function InfoCard() {
    return (
        <section id='info-card'>
            <div className="info-section-photo-right">
                <div className="info-text">
                    <div>
                        <h2>Обучение</h2>
                        <p className="b2">Изучай вопросы по подборкам и направлениям в удобном ритме.
                            К каждому заданию мы подготовили емкие разборы от практикующих мидлов и сеньоров:
                            никаких бесконечных лонгридов, только суть,
                            наглядные примеры кода и правильная логика ответа.</p>
                    </div>
                    <MainButton text="Попробовать" classes={["but2"]}/>
                </div>
                <div>
                    <LearnImage />
                </div>
            </div>
            <div className="info-section-photo-left">
                <div className="info-text">
                    <div>
                        <h2>Экзамен</h2>
                        <p className="b2">Полная симуляция технического собеседования с таймером
                            и случайной выборкой вопросов по твоему стеку.
                            Проверь, насколько быстро ты соображаешь под давлением времени,
                            найди слабые места в знаниях и получи подробную аналитику своей готовности.</p>
                    </div>
                    <MainButton text="Попробовать" classes={["but2"]}/>
                </div>
                <div>
                    <ExamImage />
                </div>
            </div>
        </section>
    )
}

const formButtons = [
    "Котики", "Зум", "led-подсветка", "Дошик", "Кофе", "Сникерс", "Энергетик", "Хабр",
    "Чипсы", "Пицца", "Макбук", "Монитор", "Мышка", "Гугл", "Гит", "Аниме", "Стим",
    "Дедлайн", "Гик", "Борода", "Очки", "Терминал"
]

export function FormCard() {
    return (
        <section id='form-card'>
            <div>
                <h1>Не знаешь, с чего начать?</h1>
                <p className="b1">
                    Заполни анкету, и мы подберем идеальное<br/> IT-направление под твой вайб.
                </p>
            </div>
            <div className="form-container">
                <div className="form">
                    <h2>Анкета</h2>
                    <Input text="Имя" />
                    <div>
                        <p className="b2">Выбери до 5 интересов:</p>
                        <div className="form-buttons">
                            {formButtons.map((button) => (
                                <FromButton text={button} />
                            ))}
                        </div>
                    </div>
                </div>
                <MainButton text="Подобрать профессию" classes={["but1"]}/>
            </div>
        </section>
    )
}

export function WheelCard() {
    return (
        <section id='wheel-card'>
            <h2>Крути колесо — узнай свою профессию!</h2>
            <div className="wheel">
                <img src="/assets/wheel.png" alt=")"/>
            </div>
        </section>
    )
}