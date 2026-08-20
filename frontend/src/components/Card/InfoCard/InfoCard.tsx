import './InfoCard.css'

import {Button} from "../../Buttons/Button";
import {LearnImage} from "../../Images/BackgroundImage/LearnImage";
import {ExamImage} from "../../Images/BackgroundImage/ExamImage";

import { useNavigate } from 'react-router-dom';

export function InfoCard() {
    const navigate = useNavigate();

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
                    <Button text="Попробовать"
                            classes={["but2", "main-button"]}
                            onClick={() => navigate('/test')}
                    />
                </div>
                <div className="info-visual">
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
                    <Button text="Попробовать"
                            classes={["but2", "main-button"]}
                            onClick={() => navigate('/test')}
                    />
                </div>
                <div className="info-visual">
                    <ExamImage />
                </div>
            </div>
        </section>
    )
}