const SKILL_DIR = '/assets/skills'

export const skillIcons = {
    java: `${SKILL_DIR}/java.png`,
    js: `${SKILL_DIR}/js.png`,
    css: `${SKILL_DIR}/css.png`,
    cpp: `${SKILL_DIR}/cpp.png`,
    kotlin: `${SKILL_DIR}/kotlin.png`,
    csharp: `${SKILL_DIR}/csharp.png`,
    vscode: `${SKILL_DIR}/vscode.png`,
    git: `${SKILL_DIR}/git.png`,
    nodejs: `${SKILL_DIR}/nodejs.png`,
    sql: `${SKILL_DIR}/sql.png`,
    go: `${SKILL_DIR}/go.png`,
    photoshop: `${SKILL_DIR}/photoshop.png`,
    illustrator: `${SKILL_DIR}/illustrator.png`,
    html: `${SKILL_DIR}/html.png`,
    php: `${SKILL_DIR}/php.png`,
    sqlite: `${SKILL_DIR}/sqlite.png`,
    python: `${SKILL_DIR}/python.png`,
    code: `${SKILL_DIR}/code.png`,
    docker: `${SKILL_DIR}/docker.png`,
} as const

export type SkillId = keyof typeof skillIcons

const aliases: Record<string, SkillId> = {
    java: 'java',
    джава: 'java',
    js: 'js',
    javascript: 'js',
    'java script': 'js',
    джаваскрипт: 'js',
    go: 'go',
    golang: 'go',
    го: 'go',
    css: 'css',
    css3: 'css',
    'c++': 'cpp',
    cpp: 'cpp',
    cplusplus: 'cpp',
    kotlin: 'kotlin',
    котлин: 'kotlin',
    'c#': 'csharp',
    csharp: 'csharp',
    'c sharp': 'csharp',
    vscode: 'vscode',
    'vs code': 'vscode',
    'visual studio code': 'vscode',
    qa: 'vscode',
    тестирование: 'vscode',
    'тестирование по': 'vscode',
    linux: 'code',
    линукс: 'code',
    тензор: 'code',
    tensor: 'code',
    code: 'code',
    git: 'git',
    гит: 'git',
    сети: 'git',
    сеть: 'git',
    networks: 'git',
    network: 'git',
    node: 'nodejs',
    nodejs: 'nodejs',
    'node.js': 'nodejs',
    sql: 'sql',
    sqlite: 'sqlite',
    администрирование: 'sqlite',
    'администрирование серверов': 'sqlite',
    photoshop: 'photoshop',
    'adobe photoshop': 'photoshop',
    ps: 'photoshop',
    illustrator: 'illustrator',
    'adobe illustrator': 'illustrator',
    html: 'html',
    html5: 'html',
    хтмл: 'html',
    php: 'php',
    пхп: 'php',
    python: 'python',
    питон: 'python',
    пайтон: 'python',
    docker: 'docker',
    докер: 'docker',
}

const skillInText: Array<[RegExp, SkillId]> = [
    [/fullstack/i, 'js'],
    [/frontend/i, 'js'],
    [/backend/i, 'go'],
    [/devops/i, 'docker'],
    [/data\s*engineer|дата[\s-]*инженер/i, 'python'],
    [/системн\w*\s+администратор|администратор/i, 'code'],
    [/сетев|networks?/i, 'git'],
    [/javascript|джаваскрипт|\bjs\b/i, 'js'],
    [/node\.?js/i, 'nodejs'],
    [/\bjava\b|джава/i, 'java'],
    [/\bcss3?\b/i, 'css'],
    [/\bc\+\+|cplusplus|\bcpp\b/i, 'cpp'],
    [/kotlin|котлин/i, 'kotlin'],
    [/\bc#|csharp/i, 'csharp'],
    [/visual studio code|vs\s*code|тестирование|\bqa\b/i, 'vscode'],
    [/linux|линукс|тензор|tensor|\bcode\b/i, 'code'],
    [/\bgit\b|гит|сет(и|ь)/i, 'git'],
    [/sqlite|администрирование/i, 'sqlite'],
    [/\bsql\b/i, 'sql'],
    [/\bgolang\b|\bgo\b/i, 'go'],
    [/photoshop/i, 'photoshop'],
    [/illustrator/i, 'illustrator'],
    [/\bhtml5?\b|хтмл/i, 'html'],
    [/\bphp\b|пхп/i, 'php'],
    [/python|питон|пайтон/i, 'python'],
    [/docker|докер/i, 'docker'],
]

function normalize(value: string): string {
    return value.trim().toLowerCase().replace(/ё/g, 'е')
}

export function resolveSkillId(value: string): SkillId | undefined {
    const key = normalize(value)
    if (key in aliases) {
        return aliases[key]
    }

    const compact = key.replace(/[\s._-]+/g, '')
    if (compact in aliases) {
        return aliases[compact]
    }

    return undefined
}

function findSkillInText(value: string): SkillId | undefined {
    for (const [pattern, skillId] of skillInText) {
        if (pattern.test(value)) {
            return skillId
        }
    }
    return undefined
}

export function getSkillIcon(
    tags: Array<{ name: string } | string> = [],
    title?: string,
): string | undefined {
    const sources = [
        ...tags.map((tag) => (typeof tag === 'string' ? tag : tag.name)),
        title ?? '',
    ].filter(Boolean)

    for (const source of sources) {
        const skillId = resolveSkillId(source)
        if (skillId) {
            return skillIcons[skillId]
        }
    }

    for (const source of sources) {
        const skillId = findSkillInText(source)
        if (skillId) {
            return skillIcons[skillId]
        }
    }

    return undefined
}
