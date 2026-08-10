import './InfoCard.css'

import {MainButton} from "../../Buttons/MainButton";
import {LearnImage} from "../../Images/BackgroundImage/LearnImage";
import {ExamImage} from "../../Images/BackgroundImage/ExamImage";

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