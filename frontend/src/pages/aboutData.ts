import { skillIcons } from '../data/skillIcons'

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
            { id: 'photoshop', label: 'Adobe Photoshop', src: skillIcons.photoshop },
            { id: 'illustrator', label: 'Adobe Illustrator', src: skillIcons.illustrator },
            { id: 'figma', label: 'Figma', src: skillIcons.figma },
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
            { id: 'python', label: 'Python', src: skillIcons.python },
            { id: 'sql', label: 'SQL', src: skillIcons.sql },
            { id: 'git', label: 'Git', src: skillIcons.git },
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
            { id: 'python', label: 'Python', src: skillIcons.python },
            { id: 'sql', label: 'SQL', src: skillIcons.sql },
            { id: 'docker', label: 'Docker', src: skillIcons.docker },
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
            { id: 'js', label: 'JavaScript', src: skillIcons.js },
            { id: 'html', label: 'HTML', src: skillIcons.html },
            { id: 'css', label: 'CSS', src: skillIcons.css },
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
            { id: 'python', label: 'Python', src: skillIcons.python },
            { id: 'sql', label: 'SQL', src: skillIcons.sql },
            { id: 'cpp', label: 'C++', src: skillIcons.cpp },
        ],
    },
]

export const projectIntro = [
    'Saby Practice — онлайн-тренажёр IT-собеседований. Мы собрали его на практике в компании «Тензор»: от анкеты и подбора профессии до тестов, экзаменов и профиля с прогрессом.',
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

export type SchemaKey = 'pk' | 'fk'

export interface SchemaColumn {
    name: string
    type: string
    key?: SchemaKey
}

export interface SchemaTable {
    name: string
    columns: SchemaColumn[]
}

export interface SchemaGroup {
    id: string
    title: string
    description: string
    tables: SchemaTable[]
}

export const schemaGroups: SchemaGroup[] = [
    {
        id: 'content',
        title: 'Контент',
        description:
            'Здесь лежит учебный материал: темы, карточки вопросов и варианты ответов. Тип карточки задаёт формат задания, теги помогают искать контент по навыкам. Отдельно хранятся вопросы FAQ для страницы помощи.',
        tables: [
            {
                name: 'topics',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'name', type: 'varchar' },
                    { name: 'code', type: 'varchar' },
                ],
            },
            {
                name: 'cards',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'topic_id', type: 'int', key: 'fk' },
                    { name: 'card_type_id', type: 'int', key: 'fk' },
                    { name: 'title', type: 'varchar' },
                ],
            },
            {
                name: 'answers',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'card_id', type: 'int', key: 'fk' },
                    { name: 'title', type: 'varchar' },
                    { name: 'is_correct', type: 'bool' },
                ],
            },
            {
                name: 'tags',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'name', type: 'varchar' },
                    { name: 'is_active', type: 'bool' },
                ],
            },
            {
                name: 'card_types',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'name', type: 'varchar' },
                ],
            },
            {
                name: 'faq',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'title', type: 'varchar' },
                    { name: 'description', type: 'text' },
                ],
            },
        ],
    },
    {
        id: 'tests',
        title: 'Тесты и профессии',
        description:
            'Профессии — направления, под которые собирается каталог тестов. У теста есть код, сложность, длительность и набор карточек в нужном порядке. Через эти таблицы контент превращается в конкретный экзамен или тренировку.',
        tables: [
            {
                name: 'professions',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'name', type: 'varchar' },
                    { name: 'description', type: 'text' },
                ],
            },
            {
                name: 'tests',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'profession_id', type: 'int', key: 'fk' },
                    { name: 'difficulty_id', type: 'int', key: 'fk' },
                    { name: 'code', type: 'varchar' },
                ],
            },
            {
                name: 'test_cards',
                columns: [
                    { name: 'test_id', type: 'int', key: 'pk' },
                    { name: 'card_id', type: 'int', key: 'pk' },
                    { name: 'order_index', type: 'int' },
                ],
            },
            {
                name: 'difficulties',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'name', type: 'varchar' },
                ],
            },
        ],
    },
    {
        id: 'users',
        title: 'Пользователи',
        description:
            'Аккаунты, роли и прогресс. В результатах фиксируются баллы и режим — тренировка или экзамен, при этом гостевые прохождения тоже сохраняются. Счётчики по темам показывают, сколько раз пользователь уже отрабатывал раздел.',
        tables: [
            {
                name: 'users',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'username', type: 'varchar' },
                    { name: 'email', type: 'varchar' },
                    { name: 'role_id', type: 'int', key: 'fk' },
                ],
            },
            {
                name: 'roles',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'name', type: 'varchar' },
                ],
            },
            {
                name: 'user_test_results',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'user_id', type: 'int', key: 'fk' },
                    { name: 'test_id', type: 'int', key: 'fk' },
                    { name: 'mode', type: 'varchar' },
                    { name: 'score', type: 'int' },
                ],
            },
            {
                name: 'user_topic_counters',
                columns: [
                    { name: 'id', type: 'int', key: 'pk' },
                    { name: 'user_id', type: 'int', key: 'fk' },
                    { name: 'topic_id', type: 'int', key: 'fk' },
                    { name: 'completed_count', type: 'int' },
                ],
            },
        ],
    },
]

export const schemaLinksDescription =
    'Связи «многие ко многим» вынесены в отдельные таблицы, чтобы не дублировать данные. Так темы и профессии получают теги, темы привязываются к профессиям, а пользователь отмечает свои навыки.'

export const schemaLinks = [
    { name: 'topic_tags', from: 'topics', to: 'tags' },
    { name: 'profession_tags', from: 'professions', to: 'tags' },
    { name: 'topic_professions', from: 'topics', to: 'professions' },
    { name: 'user_tags', from: 'users', to: 'tags' },
]
