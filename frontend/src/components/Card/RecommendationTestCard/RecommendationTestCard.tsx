import './RecommendationTestCard.css'
import {Button} from "../../Buttons/Button";
import {Tab} from "../../Tabs/Tab";

const tabs: string[] = [
    "Котики", "Зум", "led-подсветка"
]

export function RecommendationTestCard() {
    return (
        <section id='recommendation-test-card'>
            <h2>Рекомендуем пройти</h2>
            <div>
                <div id='recommendation-test-info'>
                    <div>
                        <h3>Название</h3>
                        <div id='recommendation-test-tabs'>
                            {tabs.map(tab => (
                                <Tab text={tab} />
                            ))}
                        </div>
                        <p className='b3'>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
                            eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
                            ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
                            aliquip ex
                        </p>
                    </div>
                    <Button text={"Пройти тест"} classes={["but2", "main-button"]} />
                </div>
                <div id='recommendation-test-image'>

                </div>
            </div>
        </section>
    )
}
