import './InfoSection.css'
import { MainButton } from "../../Button/MainButton";

export function InfoSection(props: {
    title: string;
    description: string;
    textButton: string;
}) {
    return (
        <div className="info-section">
            <div className="info-text">
                <div>
                    <h2>{props.title}</h2>
                    <p className="b2">{props.description}</p>
                </div>
                <MainButton text={props.textButton} />
            </div>
            <div className="info-img-phone">

            </div>
        </div>
    );
}