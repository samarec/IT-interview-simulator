import './ExamImage.css'
import { Rectangle } from "./Rectangle";

export function ExamImage() {
    return (
        <div className="exam-image">
            <Rectangle description='left' classes={['part']} />
            <img className='part thorus1' src='/assets/Thorus1.svg' alt='' />
            <img className='part phone' src='/assets/PhoneExam.svg' alt='' />
            <img className='part vector7' src='/assets/Vector7.svg' alt='' />
        </div>
    )
}
