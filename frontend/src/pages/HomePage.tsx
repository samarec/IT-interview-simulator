import { useRef, useState } from 'react'

import './HomePage.css'
import { TrialCard } from '../components/Card/TrialCard/TrialCard'
import { AdvantagesCard } from '../components/Card/AdvantagesCard/AdvantagesCard'
import { HelloCard } from '../components/Card/HelloCard/HelloCard'
import { InfoCard } from '../components/Card/InfoCard/InfoCard'
import { FormCard } from '../components/Card/FormCard/FormCard'
import { WheelCard } from '../components/Card/WheelCard/WheelCard'
import type { ProfessionMatchResult } from '../api/professions'

export function HomePage() {
    const [match, setMatch] = useState<ProfessionMatchResult | null>(null)
    const [playerName, setPlayerName] = useState('')
    const wheelRef = useRef<HTMLDivElement>(null)

    function handleMatched(result: ProfessionMatchResult, name: string) {
        setPlayerName(name)
        setMatch(result)
        window.requestAnimationFrame(() => {
            wheelRef.current?.scrollIntoView({ behavior: 'smooth', block: 'center' })
        })
    }

    return (
        <div id="home-page">
            <div id="container-hello-advantages">
                <HelloCard />
                <AdvantagesCard />
            </div>
            <TrialCard />
            <InfoCard />
            <FormCard onMatched={handleMatched} />
            <div ref={wheelRef}>
                <WheelCard match={match} playerName={playerName} />
            </div>
        </div>
    )
}
