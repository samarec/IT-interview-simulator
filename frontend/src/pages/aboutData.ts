export interface TeamTool {
    id: string
    label: string
    src: string
}

export interface TeamMember {
    id: string
    name: string
    role: string
    quote: string
    initials: string
    photo?: string
    tools: TeamTool[]
}

export interface StackGroup {
    id: string
    title: string
    items: string[]
}

export const teamMembers: TeamMember[] = [
    {
        id: 'alina-ganzha',
        name: 'Алина Ганжа',
        role: 'UI/UX дизайнер',
        quote: 'Два года работаю дизайнером в EdTech. Люблю постоянно изучать что-то новое не только в дизайне, но и в смежных областях: искусстве и маркетинге.',
        initials: 'АГ',
        photo: '/assets/team/alina-ganzha.png',
        tools: [
            { id: 'figma', label: 'Figma', src: '/assets/Icons/figma.svg' },
            { id: 'photoshop', label: 'Adobe Photoshop', src: '/assets/Icons/photoshop.svg' },
            { id: 'illustrator', label: 'Adobe Illustrator', src: '/assets/Icons/illustrator.svg' },
        ],
    },
    {
        id: 'ivan-chistyakov',
        name: 'Иван Чистяков',
        role: 'Backend-разработчик',
        quote: 'Из активного — турники и брусья, просто чтобы в форме себя чувствовать. Из сидячего — настолки, любые, главное чтобы компания была. Ну и если выпадает выходной, выбираюсь в лес с друзьями.',
        initials: 'ИЧ',
        photo: '/assets/team/ivan-chistyakov.png',
        tools: [
            { id: 'python', label: 'Python', src: '/assets/skills/python.png' },
            { id: 'sql', label: 'SQL', src: '/assets/skills/sql.png' },
        ],
    },
    {
        id: 'nikita-melnikov',
        name: 'Никита Мельников',
        role: 'Backend-разработчик',
        quote: 'Активно посещаю IT мероприятия. Участвую в чемпионатах по программированию. Занимаюсь собственным музыкальным журналом.',
        initials: 'НМ',
        photo: '/assets/team/nikita-melnikov.png',
        tools: [
            { id: 'python', label: 'Python', src: '/assets/skills/python.png' },
            { id: 'sql', label: 'SQL', src: '/assets/skills/sql.png' },
            { id: 'illustrator', label: 'Adobe Illustrator', src: '/assets/skills/csharp.png' },
        ],
    },
    {
        id: 'egor-shmakov',
        name: 'Егор Шмаков',
        role: 'Frontend-разработчик',
        quote: 'В первые начал изучение frontend месяц назад, тогда я ещё не знал насколько это интересно и в то же время сложно. Но получился очень хороший опыт. Спасибо компании «Тензор» за возможность проявить себя.',
        initials: 'ЕШ',
        photo: '/assets/team/egor-shmakov.png',
        tools: [
            { id: 'figma', label: 'Figma', src: '/assets/skills/react.png' },
            { id: 'photoshop', label: 'Adobe Photoshop', src: '/assets/skills/ts.png' },
            { id: 'illustrator', label: 'Adobe Illustrator', src: '/assets/skills/css.png' },
        ],
    },
    {
        id: 'maxim-dementiev',
        name: 'Максим Дементьев',
        role: 'Backend-разработчик',
        quote: 'Стараюсь везде придерживаться тайм менеджмента и попадать в дедлайны, а именно: \n' +
            '10 км бегаю за 53 минуты;\n' +
            'быструю сортировку пишу за 19 минут;\n' +
            'на руках стою 3 минуты;\n' +
            'в бассейне 50м проплываю за 35 секунд.',
        initials: 'МД',
        photo: '/assets/team/maxim-dementiev.png',
        tools: [
            { id: 'python', label: 'Python', src: '/assets/skills/python.png' },
            { id: 'sql', label: 'SQL', src: '/assets/skills/sql.png' },
            { id: 'illustrator', label: 'Adobe Illustrator', src: '/assets/skills/cpp.png' },
        ],
    },
]

export const techStack: StackGroup[] = [
    {
        id: 'frontend',
        title: 'Frontend',
        items: ['React', 'TypeScript', 'CSS'],
    },
    {
        id: 'backend',
        title: 'Backend',
        items: ['Python', 'Uvicorn', 'FastAPI'],
    },
    {
        id: 'db',
        title: 'DB',
        items: ['SQLAlchemy', 'PostgreSQL'],
    },
]
