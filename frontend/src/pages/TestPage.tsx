import './TestPage.css'

import {StatisticsTestCard} from "../components/Card/StatisticsTestCard/StatisticsTestCard";
import {CategoriesTestCard} from "../components/Card/CaregoriesTestCard/CategoriesTestCard";
import {RecommendationTestCard} from "../components/Card/RecommendationTestCard/RecommendationTestCard";
import {AllTestCard} from "../components/Card/AllTestCard/AllTestCard";

export default function TestPage() {
    return (
        <div id='test-page'>
            <StatisticsTestCard />
            <CategoriesTestCard />
            <RecommendationTestCard />
            <AllTestCard />
        </div>
    )
}