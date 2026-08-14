import './TestCard.css'
import {Button} from "../../Buttons/Button";
import {Tab} from "../../Tabs/Tab";

export function TestCard(props: {
    title: string
    countQuestion: number
    timeMin: number
    level: string
    description: string
    countPeoples: number
}) {
    return (
        <div className="test-card gradient-wight-card-fill">
            <h3>{props.title}</h3>
            <div>
                <div className='test-tabs'>
                    <Tab text={props.countQuestion + " вопросов"} icon={'/assets/Icons/iconQuestion.svg'}/>
                    <Tab text={props.timeMin + " минут"} icon={'/assets/Icons/iconClock.svg'} />
                    <Tab text={props.level} />
                </div>
                <p className='b3'>{props.description}</p>
            </div>
            <Button text={"Пройти тест"} classes={['but2', 'main-button']} />
        </div>
    )
}