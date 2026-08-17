import './Input.css'

export function Input(props: {
    text: string
    value?: string
    onChange?: (value: string) => void
    type?: string
    name?: string
    autoComplete?: string
    disabled?: boolean
}) {
    return (
        <input
            className="input gradient-withe-input"
            title={props.text}
            placeholder={props.text}
            type={props.type ?? 'text'}
            name={props.name}
            value={props.value}
            onChange={props.onChange ? (event) => props.onChange?.(event.target.value) : undefined}
            autoComplete={props.autoComplete}
            disabled={props.disabled}
        />
    )
}
