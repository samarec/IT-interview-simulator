import './Search.css'

export function Search(props: {
    text: string
    value?: string
    onChange?: (value: string) => void
}) {
    return (
        <div className="search">
            <img src="/assets/Icons/iconSearch.svg" alt="" width={20} height={20} />
            <input
                className="search-field"
                type="text"
                placeholder={props.text}
                value={props.value}
                onChange={(event) => props.onChange?.(event.target.value)}
            />
        </div>
    )
}
