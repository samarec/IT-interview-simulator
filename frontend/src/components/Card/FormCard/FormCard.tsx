import './FormCard.css'

import {Input} from "../../Input/Input";
import {Button} from "../../Buttons/Button";

const formButtons = [
    "Котики", "Зум", "led-подсветка", "Дошик", "Кофе", "Сникерс", "Энергетик", "Хабр",
    "Чипсы", "Пицца", "Макбук", "Монитор", "Мышка", "Гугл", "Гит", "Аниме", "Стим",
    "Дедлайн", "Гик", "Борода", "Очки", "Терминал"
]

export function FormCard() {
    return (
        <div className='background-container'>
            <section id='form-card'>
                <div>
                    <h1>Не знаешь, с чего начать?</h1>
                    <p className="b2">
                        Заполни анкету, и мы подберем идеальное IT-направление под твой вайб.
                    </p>
                </div>
                <div className="form-container gradient-wight-card-fill">
                    <div className="form">
                        <h2>Анкета</h2>
                        <Input text="Имя" />
                        <div>
                            <p className="b2">Выбери до 5 интересов:</p>
                            <div className="form-buttons">
                                {formButtons.map((button) => (
                                    <Button text={button} classes={['form-button']} />
                                ))}
                            </div>
                        </div>
                    </div>
                    <Button text="Подобрать профессию" classes={["but1", "main-button"]}/>
                </div>
            </section>
            <img id='vector2-background-form' className='part' src='/assets/Vector2.svg' alt=''/>
            <img id='helix-background-form' className='part' src='/assets/Helix.png' alt=''/>
            <img id='group3-background-form' className='part' src='/assets/Group3.svg' alt=''/>
            <img id='thours-background-form' className='part' src='/assets/Thorus2.png' alt=''/>
        </div>

    )
}