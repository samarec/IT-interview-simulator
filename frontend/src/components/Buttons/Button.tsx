import './MainButton.css'
import './MenuButton.css'
import './FormButton.css'

export function Button(props: {text: string, classes: string[]}) {
    const classes = props.classes;

    return (
        <button className={classes.join(' ')}>
            {props.text}
        </button>
    )
}