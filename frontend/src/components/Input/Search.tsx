import './Search.css'

export function Search(props: {text: string}) {
    return (
        <input className="search" title="text" placeholder={props.text}/>
    )
}