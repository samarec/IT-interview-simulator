import './HomePage.css'
import {TrialCard} from "../components/Card/TrialCard/TrialCard";
import {AdvantagesCard} from "../components/Card/AdvantagesCard/AdvantagesCard";
import {HelloCard} from "../components/Card/HelloCard/HelloCard";
import {InfoCard} from "../components/Card/InfoCard/InfoCard";
import {FormCard} from "../components/Card/FormCard/FormCard";
import {WheelCard } from '../components/Card/WheelCard/WheelCard';

export function HomePage() {
    return (
        <div id="home-page">
            <div id="container-hello-advantages">
                <HelloCard />
                <AdvantagesCard />
            </div>
            <TrialCard />
            <InfoCard />
            <FormCard />
            <WheelCard />
        </div>
    )
}
