import './AdvantageCard.css'

export function AdvantageCard(props: {id: number, title: string, description: string}) {
    const classes = ['advantage-card', 'gradient-wight-card-fill'];
    props.id % 2 === 0 ? classes.push("rotate") : classes.push("rotate-neg");

    return (
        <div className={classes.join(' ')}>
            <div className="advantage-card-number rotate">{props.id}</div>
            <div className="advantage-card-info">
                <h2>{props.title}</h2>
                <p className='b2'>{props.description}</p>
            </div>
        </div>
    )
}