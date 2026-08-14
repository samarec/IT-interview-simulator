import './Header.css';

import {useNavigate} from 'react-router-dom';
import {Button} from "../Buttons/Button";
import {navItems} from "./headerData";

export default function Header() {
    const navigate = useNavigate();

    return (
        <header className="header">
            <div id="image-header-logo">
                {/*логотип*/}
            </div>
            <div className="header-logo">ЛОГО</div>

            <nav className="nav">
                {navItems.map((item) => (
                    <Button text={item.title} onClick={() => navigate(item.href)} classes={['menu-button']}/>
                ))}
            </nav>
        </header>
    )
};