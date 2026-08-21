import { useEffect, useState } from 'react'

import './AboutPage.css'

import { InfoCard } from '../components/Card/InfoCard/InfoCard'

import { projectIntro, schemaGroups, schemaLinks, schemaLinksDescription, teamMembers, techStack } from './aboutData'

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

                <section className="about-section about-project" aria-labelledby="about-project-title">
                    <h2 id="about-project-title">О проекте</h2>
                    <div className="about-project-lead">
                        {projectIntro.map((paragraph) => (
                            <p key={paragraph} className="b2">{paragraph}</p>
                        ))}
                    </div>
                    <InfoCard />
                </section>

                <section className="about-section about-schema" aria-labelledby="about-schema-title">
                    <h2 id="about-schema-title">База данных</h2>
                    <p className="b2 about-schema-lead">
                        PostgreSQL, схема <code>z1</code>. Контент, тесты и пользователи связаны через
                        внешние ключи и таблицы-связки.
                    </p>

                    <div className="schema-legend">
                        <span className="schema-key schema-key--pk">PK</span>
                        <span className="b3">первичный ключ</span>
                        <span className="schema-key schema-key--fk">FK</span>
                        <span className="b3">внешний ключ</span>
                    </div>

                    <div className="schema-groups">
                        {schemaGroups.map((group) => (
                            <div key={group.id} className="schema-group">
                                <h3>{group.title}</h3>
                                <p className="b2 schema-group-lead">{group.description}</p>
                                <div className="schema-tables">
                                    {group.tables.map((table) => (
                                        <article key={table.name} className="schema-table">
                                            <header className="schema-table-head">
                                                <span>{table.name}</span>
                                            </header>
                                            <ul>
                                                {table.columns.map((column) => (
                                                    <li key={column.name}>
                                                        <span className="schema-col-name">{column.name}</span>
                                                        <span className="schema-col-meta">
                                                            {column.key && (
                                                                <span className={`schema-key schema-key--${column.key}`}>
                                                                    {column.key.toUpperCase()}
                                                                </span>
                                                            )}
                                                            <span className="schema-col-type">{column.type}</span>
                                                        </span>
                                                    </li>
                                                ))}
                                            </ul>
                                        </article>
                                    ))}
                                </div>
                            </div>
                        ))}
                    </div>

                    <div className="schema-links-block">
                        <h3>Связки M:N</h3>
                        <p className="b2 schema-group-lead">{schemaLinksDescription}</p>
                        <div className="schema-links">
                            {schemaLinks.map((link) => (
                                <article key={link.name} className="schema-link">
                                    <strong>{link.name}</strong>
                                    <span>{link.from}</span>
                                    <span className="schema-link-arrow" aria-hidden="true" />
                                    <span>{link.to}</span>
                                </article>
                            ))}
                        </div>
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
