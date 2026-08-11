import './ExamImage.css'
import { Rectangle } from "./Rectangle";

export function ExamImage() {
    return (
        <div className="exam-image">
            <Rectangle description='left' classes={['part']} />
            <img id='thorus1-exam-image' className='part' src='/assets/Thorus1.png' alt='' />
            <img id='phone-exam-image' className='part' src='/assets/PhoneExam.svg' alt='' />
            <img id='vector7-exam-image' className='part' src='/assets/Vector7.svg' alt='' />
        </div>
    )
}
