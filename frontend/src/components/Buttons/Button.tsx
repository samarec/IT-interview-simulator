import './MainButton.css'
import './MenuButton.css'
import './FormButton.css'

export function Button(props: {text: string, onClick?: () => void | Promise<void>, classes: string[]}) {
    const classes = props.classes;

    return (
        <button className={classes.join(' ')} onClick={props.onClick}>
            {props.text}
        </button>
    )
}