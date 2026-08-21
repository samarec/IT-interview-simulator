import './TestCard.css'
import { useNavigate } from 'react-router-dom'
import { Button } from '../../Buttons/Button'
import { Tab } from '../../Tabs/Tab'
import { getSkillIcon } from '../../../data/skillIcons'
import type { TopicTag } from '../../../pages/testData'

export function TestCard(props: {
    title: string
    code?: string | null
    countQuestion: number
    timeMin: number
    level: string
    description: string
    passedCount: number
    tags?: TopicTag[]
}) {
    const navigate = useNavigate()
    const skillIcon = getSkillIcon(props.tags ?? [], props.title)
    const href = props.code ? `/test/${props.code}` : '/test'

    return (
        <div className="test-card-wrap">
            <div className="test-card">
                <h3>{props.title}</h3>
                <div className="test-card-body">
                    <div className="test-tabs">
                        <Tab text={`${props.countQuestion} вопросов`} icon="/assets/Icons/iconQuestion.svg" />
                        <Tab text={`${props.timeMin} минут`} icon="/assets/Icons/iconClock.svg" />
                        <Tab text={props.level} />
                    </div>
                    <p className="b3">{props.description}</p>
                </div>
                <div className="test-card-footer">
                    <Button
                        text="Пройти тест"
                        onClick={() => navigate(href)}
                        classes={['but2', 'main-button']}
                    />
                    <div className="test-card-passed">
                        <img src="/assets/Icons/iconUser.svg" alt="" />
                        <span className="b3">{props.passedCount}</span>
                    </div>
                </div>
            </div>
            {skillIcon && (
                <img className="test-card-skill" src={skillIcon} alt="" />
            )}
        </div>
    )
}
