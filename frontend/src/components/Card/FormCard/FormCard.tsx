import {useState} from 'react'

import './FormCard.css'

import {Input} from "../../Input/Input";
import {Button} from "../../Buttons/Button";

const MAX_INTERESTS = 5

const formButtons = [
    "Котики", "Зум", "led-подсветка", "Дошик", "Кофе", "Сникерс", "Энергетик", "Хабр",
    "Чипсы", "Пицца", "Макбук", "Монитор", "Мышка", "Гугл", "Гит", "Аниме", "Стим",
    "Дедлайн", "Гик", "Борода", "Очки", "Терминал"
]

export function FormCard() {
    const [selectedInterests, setSelectedInterests] = useState<string[]>([])

    function toggleInterest(interest: string) {
        setSelectedInterests((current) => {
            if (current.includes(interest)) {
                return current.filter((item) => item !== interest)
            }
            if (current.length >= MAX_INTERESTS) {
                return current
            }
            return [...current, interest]
        })
    }

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
                                    <Button
                                        key={button}
                                        text={button}
                                        onClick={() => toggleInterest(button)}
                                        classes={[
                                            'form-button',
                                            selectedInterests.includes(button) ? 'form-button--selected' : '',
                                        ]}
                                    />
                                ))}
                            </div>
                        </div>
                    </div>
                    <Button
                        text="Подобрать профессию"
                        classes={["but1", "main-button"]}
                        disabled={selectedInterests.length === 0}
                    />
                </div>
            </section>
            <img id='vector2-background-form' className='part' src='/assets/Vector2.svg' alt=''/>
            <img id='helix-background-form' className='part' src='/assets/Helix.png' alt=''/>
            <img id='group3-background-form' className='part' src='/assets/Group3.svg' alt=''/>
            <img id='thours-background-form' className='part' src='/assets/Thorus2.png' alt=''/>
        </div>

    )
}