import './Header.css';
import {MenuButton} from "../Buttons/MenuButton";
import {navItems} from "./headerData";

export default function Header() {
    return (
        <header className="header">
            <div id="image-header-logo">
                {/*логотип*/}
            </div>
            <div className="header-logo">ЛОГО</div>

            <nav className="nav">
                {navItems.map((item) => (
                    <MenuButton id={item.id} text={item.title} />
                ))}
            </nav>
        </header>
    )
};