import './styles/main.css'

import {BrowserRouter, Route, Routes, useLocation} from "react-router-dom";
import Header from "./components/Header/Header";
import { Footer } from "./components/Footer/Footer";
import { FloatingPrimitives } from "./components/Images/FloatingPrimitives/FloatingPrimitives";
import { AuthProvider } from "./context/AuthContext";
import { HomePage } from "./pages/HomePage";
import { AboutPage } from "./pages/AboutPage";
import { FaqPage } from "./pages/FaqPage";
import { ProfilePage } from "./pages/ProfilePage";
import TestPage from "./pages/TestPage";
import { TestIntroPage } from "./pages/TestIntroPage";
import { TestRunPage } from "./pages/TestRunPage";

function AppLayout() {
    const location = useLocation()
    const isTestSession = /^\/test\/[^/]+\/[^/]+/.test(location.pathname)

    return (
        <AuthProvider>
            <FloatingPrimitives />
            <Header />
            <Routes>
                <Route path="/" element={<HomePage />} />
                <Route path="/about" element={<AboutPage />} />
                <Route path="/test" element={<TestPage />} />
                <Route path="/test/:code" element={<TestIntroPage />} />
                <Route path="/test/:code/:mode" element={<TestRunPage />} />
                <Route path="/faq" element={<FaqPage />} />
                <Route path="/profile" element={<ProfilePage />} />
            </Routes>
            {!isTestSession && <Footer />}
        </AuthProvider>
    )
}

export default function App() {
    return (
        <BrowserRouter>
            <AppLayout />
        </BrowserRouter>
    )
}
