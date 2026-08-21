import './TrialCard.css'

export function TrialCard() {
    return (
        <div className="background-container">
            <section id='trial-card'>
                <h2>Готов попробовать прямо сейчас?</h2>
                <div>
                    <div id="trial-qr" className='gradient-wight-card-fill'>
                        <div>
                            <img src="/assets/trial-qr.svg?v=2" alt="QR-код тренажёра" />
                        </div>
                        <p className="b2">Наведи камеру и ворвись в интерактив</p>
                    </div>
                    <p className="b2">Сканируй QR-код камерой телефона, запускай тренажер и проверь свои силы в режиме реального времени.
                        Никаких долгих регистраций — сразу к делу!</p>
                </div>
            </section>
            <img id='thorus-kont-background-trial' className='part' src='/assets/ThorusKnot.png' alt='' />
            <img id='group4-background-trial' className='part' src='/assets/Group4.svg' alt='' />
            <img id='vector7-background-trial' className='part' src='/assets/Vector7.svg' alt='' />
        </div>

    )
}