import './styles/main.less'

import Header from "./components/Header/Header";
import { HomePage } from "./pages/HomePage";

export default function App() {
    return (
        <>
            <Header />
            <HomePage />
        </>
    )
}
