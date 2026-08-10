import './Header.css';
import {MenuButton} from "../Button/MenuButton";
import {navItems} from "./headerData";

export default function Header() {
    return (
        <header className="header">
            <div className="header-logo">LOGO</div>

            <nav className="nav">
                {navItems.map((item) => (
                    <MenuButton id={item.id} text={item.title} />
                ))}
            </nav>
        </header>
    )
};