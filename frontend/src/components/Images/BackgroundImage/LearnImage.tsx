import './LearnImage.css'
import {Rectangle} from "./Rectangle";

export function LearnImage() {
    return (
        <div className="learn-image">
            <img id='cube-learn-image' className='part' src='/assets/Cube1.png' alt='' />
            <img id='group3-learn-image' className='part group3' src='/assets/Group3.svg' alt='' />
            <img id='group4-learn-image' className='part group4' src='/assets/Group4.svg' alt='' />
            <img id='phone-learn-image' className='part phone' src='/assets/PhoneLearn.svg' alt='' />
            <Rectangle description={'right'} classes={['part']}/>
        </div>
    )
}