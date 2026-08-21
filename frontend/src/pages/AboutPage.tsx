import { useEffect, useState } from 'react'

import './AboutPage.css'

import { teamMembers, techStack } from './aboutData'

function ChevronIcon({ direction }: { direction: 'prev' | 'next' }) {
    const isPrev = direction === 'prev'

    return (
        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" aria-hidden="true">
            <path
                d={isPrev ? 'M12.5 4.5 7 10l5.5 5.5' : 'M7.5 4.5 13 10l-5.5 5.5'}
                stroke="white"
                strokeWidth="2.2"
                strokeLinecap="round"
                strokeLinejoin="round"
            />
        </svg>
    )
}

export function AboutPage() {
    const [activeIndex, setActiveIndex] = useState(0)
    const [photoFailed, setPhotoFailed] = useState(false)

    const member = teamMembers[activeIndex]
    const canSlide = teamMembers.length > 1

    useEffect(() => {
        setPhotoFailed(false)
    }, [member.id])

    function showPrev() {
        setActiveIndex((current) => (
            current === 0 ? teamMembers.length - 1 : current - 1
        ))
    }

    function showNext() {
        setActiveIndex((current) => (
            current === teamMembers.length - 1 ? 0 : current + 1
        ))
    }

    const showPhoto = Boolean(member.photo) && !photoFailed

    return (
        <div id="about-page">
                <div className="background-container about-intro-wrap">
                    <section className="about-intro">
                        <h1>Наша команда</h1>
                        <p className="b2">
                            Познакомьтесь с командой Saby Practice — листайте карточки
                            и узнайте немного больше о каждом из нас.
                        </p>
                    </section>
                    <img id="cube-background-about" className="part" src="/assets/Cube1.png" alt="" />
                    <img id="helix-background-about" className="part" src="/assets/Helix.png" alt="" />
                    <img id="stripes-top-about" className="part" src="/assets/Group5.svg" alt="" />
                    <img id="stripes-bottom-about" className="part" src="/assets/Group5.svg" alt="" />
                </div>

                <section className="about-section" aria-labelledby="about-team-title">
                    <h2 id="about-team-title">Команда</h2>

                    <div className="team-slider">
                        <button
                            type="button"
                            className="team-nav"
                            onClick={showPrev}
                            disabled={!canSlide}
                            aria-label="Предыдущий участник"
                        >
                            <ChevronIcon direction="prev" />
                        </button>

                        <article className="team-card gradient-wight-card-fill" key={member.id}>
                            <div className="team-card-text">
                                <div className="team-card-heading">
                                    <h3>{member.name}</h3>
                                    <p className="b3">{member.role}</p>
                                </div>
                                <p className="team-quote b2">{member.quote}</p>
                            </div>

                            <div className="team-card-visual">
                                <img
                                    className="team-photo-bg"
                                    src="/assets/back_img.png"
                                    alt=""
                                />
                                {showPhoto ? (
                                    <img
                                        className="team-photo"
                                        src={member.photo}
                                        alt={member.name}
                                        onError={() => setPhotoFailed(true)}
                                    />
                                ) : (
                                    <div className="team-photo team-photo--placeholder" aria-hidden="true">
                                        <span>{member.initials}</span>
                                    </div>
                                )}

                                {member.tools.length > 0 && (
                                    <ul className="team-tools">
                                        {member.tools.map((tool) => (
                                            <li key={tool.id} className="team-tool">
                                                <img src={tool.src} alt="" />
                                                <span className="visually-hidden">{tool.label}</span>
                                            </li>
                                        ))}
                                    </ul>
                                )}
                            </div>
                        </article>

                        <button
                            type="button"
                            className="team-nav"
                            onClick={showNext}
                            disabled={!canSlide}
                            aria-label="Следующий участник"
                        >
                            <ChevronIcon direction="next" />
                        </button>
                    </div>
                </section>

                <section className="about-section about-stack" aria-labelledby="about-stack-title">
                    <img
                        className="about-wave"
                        src="/assets/about-wave.svg"
                        alt=""
                    />
                    <h2 id="about-stack-title">Стек технологий</h2>
                    <div className="stack-grid">
                        {techStack.map((group) => (
                            <article key={group.id} className="stack-card">
                                <h3>{group.title}</h3>
                                <ul>
                                    {group.items.map((item) => (
                                        <li key={item} className="b2">{item}</li>
                                    ))}
                                </ul>
                            </article>
                        ))}
                    </div>
                </section>
        </div>
    )
}
