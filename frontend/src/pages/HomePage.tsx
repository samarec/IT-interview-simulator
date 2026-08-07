import './HomePage.css'
import { HelloCard, AdvantagesCard, TrialCard, InfoCard, FormCard, WheelCard } from '../components/Card/Card';

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