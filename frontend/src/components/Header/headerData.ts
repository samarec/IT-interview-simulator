interface HeaderData {
    id: string;
    title: string;
    href: string;
}

export const navItems: HeaderData[] = [
    {
        id: "1",
        title: "Главная",
        href: "/",
    },
    {
        id: "2",
        title: "О нас",
        href: "/about",
    },
    {
        id: "3",
        title: "Тесты",
        href: "/test",
    },
    {
        id: "4",
        title: "FAQ",
        href: "/faq",
    }
]