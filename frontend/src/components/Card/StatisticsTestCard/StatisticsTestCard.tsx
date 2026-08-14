import './StatisticsTestCard.css'

import {testTabs} from "./dataStatisticsTestTabs";
import {Search} from "../../Input/Search";

export function StatisticsTestCard() {
    return (
        <section id='statistics-test-card'>
            <div id='statistics-test' className='gradient-wight-card-fill'>
                <h1>Тесты</h1>
                <div id="statistics-test-tabs">
                    {testTabs.map((tab) => (
                        <div className='statistics-test-tab'>
                            <p>{tab.text}</p>
                            <h3>{tab.number}</h3>
                        </div>
                    ))}
                </div>
            </div>
            <div id='statistics-test-search'>
                <Search text={"Поиск"} />
            </div>
            <img id='pill1-background-statistics-test' className='part' src='/assets/Pill1.png' alt=''/>
            <img id='sphere-background-statistics-test' className='part' src='/assets/Sphere.png' alt=''/>
            <img id='thorus-knot-background-statistics-test' className='part' src='/assets/ThorusKnot.png' alt=''/>
            <img id='helix-background-statistics-test' className='part' src='/assets/Helix.png' alt=''/>
            <img id='group3-background-statistics-test' className='part' src='/assets/Group3.svg' alt=''/>
        </section>
    )
}