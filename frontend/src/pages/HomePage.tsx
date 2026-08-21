import { HelloCard } from '../components/Card/HelloCard/HelloCard'
import { FormCard } from '../components/Card/FormCard/FormCard'
import { TrialCard } from '../components/Card/TrialCard/TrialCard'
import { AdvantagesCard } from '../components/Card/AdvantagesCard/AdvantagesCard'
import { InfoCard } from '../components/Card/InfoCard/InfoCard'

import { projectIntro } from './aboutData'

import './HomePage.css'

export function HomePage() {
    return (
        <div id="home-page">
            <div id="container-hello-advantages">
                <HelloCard />
                <AdvantagesCard />
            </div>
            <section className="about-section about-project" aria-labelledby="about-project-title">
                <h2 id="about-project-title">О проекте</h2>
                <div className="about-project-lead">
                    {projectIntro.map((paragraph) => (
                        <p key={paragraph} className="b2">{paragraph}</p>
                    ))}
                </div>
                <InfoCard />
            </section>
            <TrialCard />
            <FormCard />
        </div>
    )
}
