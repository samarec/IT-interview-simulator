import { HelloCard } from '../components/Card/HelloCard/HelloCard'
import { FormCard } from '../components/Card/FormCard/FormCard'
import { TrialCard } from '../components/Card/TrialCard/TrialCard'
import { AdvantagesCard } from '../components/Card/AdvantagesCard/AdvantagesCard'

import './HomePage.css'

export function HomePage() {
    return (
        <div id="home-page">
            <div id="container-hello-advantages">
                <HelloCard />
                <AdvantagesCard />
            </div>
            <TrialCard />
            <FormCard />
        </div>
    )
}
