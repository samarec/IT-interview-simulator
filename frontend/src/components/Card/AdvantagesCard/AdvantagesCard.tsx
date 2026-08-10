import './AdvantagesCard.css'

import { AdvantageCard } from "./AdvantageCard";
import { advantagesCard } from "./dataAdvantageCard";

export function AdvantagesCard() {
    return (
        <div className='background-container'>
            <section id='advantages-card'>
                {advantagesCard.map((advantage) => (
                    <AdvantageCard id={advantage.id} title={advantage.title} description={advantage.description} />
                ))}
            </section>
            <img id='group4-background-advantage' className='part' src='/assets/Group4.svg' alt='' />
            <img id='thorus2-background-advantage' className='part' src='/assets/Thorus2.png' alt='' />
            <img id='vector2-background-advantage' className='part' src='/assets/Vector2.svg' alt='' />
            <img id='vector3-background-advantage' className='part' src='/assets/Vector3.svg' alt='' />
            <img id='helix-background-advantage' className='part' src='/assets/Helix.png' alt='' />
            <img id='group3-background-advantage' className='part' src='/assets/Group3.svg' alt='' />
        </div>
    );
}