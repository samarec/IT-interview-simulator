import './LearnImage.css'
import {Rectangle} from "./Rectangle";

export function LearnImage() {
    return (
        <div className="learn-image">
            <img className='part cube' src='/assets/Cube1.svg' alt='' />
            <img className='part group3' src='/assets/Group3.svg' alt='' />
            <img className='part group4' src='/assets/Group4.svg' alt='' />
            <img className='part phone' src='/assets/PhoneLearn.svg' alt='' />
            <Rectangle description={'right'} classes={['part']}/>
        </div>
    )
}