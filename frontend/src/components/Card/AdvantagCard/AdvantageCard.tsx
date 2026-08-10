import './AdvantageCard.css'

export function AdvantageCard(props: {id: number, title: string, description: string}) {
    return (
        <div className={props.id % 2 === 0 ? "advantage-card rotate" : "advantage-card rotate-neg"}>
            <div className="advantage-card-number rotate">{props.id}</div>
            <div className="advantage-card-info">
                <h2>{props.title}</h2>
                <p className='b2'>{props.description}</p>
            </div>
        </div>
    )
}