import './MainButton.css'
import './MenuButton.css'
import './FormButton.css'

export function Button(props: {
    text: string
    onClick?: () => void | Promise<void>
    classes: string[]
    disabled?: boolean
    type?: 'button' | 'submit'
}) {
    const classes = props.classes;

    return (
        <button
            type={props.type ?? 'button'}
            className={classes.join(' ')}
            onClick={props.onClick}
            disabled={props.disabled}
        >
            {props.text}
        </button>
    )
}