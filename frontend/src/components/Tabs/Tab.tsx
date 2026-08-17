import './Tab.css'

export function Tab(props: {icon?: string, text: string}) {
    if (props.icon) {
        return (
            <div className="tab">
                <img src={props.icon} alt='' />
                <p className='b3'>{props.text}</p>
            </div>
        )
    } else {
        return (
            <div className="tab">
                <p className='b3'>{props.text}</p>
            </div>
        )
    }
}