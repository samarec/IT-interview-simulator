import './FormButton.css'

export function FromButton(props: {text: string}) {
    return (
        <button className="form-button">
            {props.text}
        </button>
    )
}