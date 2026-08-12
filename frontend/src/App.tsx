import './styles/main.css'

import Header from "./components/Header/Header";
import { HomePage } from "./pages/HomePage";
import TestPage from "./pages/TestPage";

export default function App() {
    return (
        <>
            <Header />
            {/*<HomePage />*/}
            <TestPage />
        </>
    )
}
