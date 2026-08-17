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
