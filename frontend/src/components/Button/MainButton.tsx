import './MainButton.css'

export function MainButton(props: {text: string}) {
    return (
        <button className="main-button">
            {props.text}
        </button>
    )
}