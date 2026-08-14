import './AllTestCard.css'
import {TestCard} from "./Testcard";
import {dataTests} from "./dataTest";
import {Button} from "../../Buttons/Button";

export function AllTestCard() {
    return (
        <section id="all-test-card">
            {/*<div className='double-test-card'>*/}

            {/*</div>*/}
            <div className='single-test-card'>
                {dataTests.map((test) => (
                    <TestCard title={test.title}
                              countQuestion={test.countQuestion}
                              timeMin={test.timeMin}
                              level={test.level}
                              description={test.description}
                              countPeoples={test.countPeoples} />
                ))}
                <Button text={'Показать ещё'} classes={['main-button', 'but1']} />
            </div>
        </section>
    )
}
