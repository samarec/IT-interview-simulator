import './UserAvatar.css'

import { getInitials } from '../../api/auth'

export function UserAvatar(props: { username: string; size?: 'header' | 'profile' }) {
    return (
        <span className={`user-avatar user-avatar--${props.size ?? 'header'}`}>
            {getInitials(props.username)}
        </span>
    )
}
