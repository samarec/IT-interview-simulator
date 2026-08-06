import './MenuButton.css'

export function MenuButton(props: {id: string, text: string}) {
    return (
        <button id={props.id} className="menu-button">
            {props.text}
        </button>
    )
}