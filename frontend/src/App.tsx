import './styles/main.css'

import {BrowserRouter, Route, Routes} from "react-router-dom";
import Header from "./components/Header/Header";
import { HomePage } from "./pages/HomePage";
import TestPage from "./pages/TestPage";

export default function App() {
    return (
        <BrowserRouter>
            <Header />
            <Routes>
                <Route path="/" element={<HomePage />} />
                <Route path="/test" element={<TestPage />} />
            </Routes>
        </BrowserRouter>
    )
}
