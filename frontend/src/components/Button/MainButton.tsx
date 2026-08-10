import './MainButton.css'

export function MainButton(props: {text: string, classes: string[]}) {
    const classes = props.classes;
    classes.push("main-button");

    return (
        <button className={classes.join(' ')}>
            {props.text}
        </button>
    )
}