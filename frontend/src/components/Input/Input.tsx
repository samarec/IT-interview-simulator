import './Input.css'

export function Input(props: {text: string}) {
    return (
        <input className="input gradient-withe-input" title="text" placeholder={props.text}/>
    )
}