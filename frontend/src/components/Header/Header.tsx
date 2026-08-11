import './Header.css';
import {Button} from "../Buttons/Button";
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
                    <Button text={item.title} classes={['menu-button']}/>
                ))}
            </nav>
        </header>
    )
};