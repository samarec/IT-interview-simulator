import './Footer.css'

import {Link} from 'react-router-dom';
import {navItems} from "../Header/headerData";
import {popularTests} from "./footerData";

export function Footer() {
    return (
        <div className="footer-wrap gradient-wight-card-fill">
            <div className="background-container footer-inner">
                <footer id="footer">
                    <div className="footer-brand">
                        <div className="footer-brand-title">
                            <img src="/assets/LogoBird.svg" alt="" />
                            <h3><span>saby</span> практика</h3>
                        </div>
                        <p className="b3">Пошаговая подготовка к техническим интервью в формате удобных билетов.</p>
                    </div>
                    <div className="footer-columns">
                        <div className="footer-column">
                            <h4>Навигация</h4>
                            <nav>
                                {navItems.map((item) => (
                                    <Link key={item.id} to={item.href} className="footer-link">{item.title}</Link>
                                ))}
                            </nav>
                        </div>
                        <div className="footer-column">
                            <h4>Популярные тесты</h4>
                            <nav>
                                {popularTests.map((test) => (
                                    <Link key={test.id} to={test.href} className="footer-link">{test.title}</Link>
                                ))}
                            </nav>
                        </div>
                    </div>
                </footer>
                <img id="thorus-knot-background-footer" className="part" src="/assets/ThorusKnot.png" alt="" />
                <img id="helix-background-footer" className="part" src="/assets/Helix.png" alt="" />
                <img id="cube-background-footer" className="part" src="/assets/Cube1.png" alt="" />
            </div>
        </div>
    )
}
