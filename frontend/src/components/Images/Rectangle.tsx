export function Rectangle(props: { description: 'left' | 'right', classes: string[] }) {
    const transform = props.description === 'left' ? 'scaleX(-1)' : 'scaleX(1)';
    const classes = props.classes;
    classes.push('rectangle');

    return (
        <img className={classes.join(' ')} src='/assets/RectangleRight.svg' style={{ transform }} alt='' />
    )
}