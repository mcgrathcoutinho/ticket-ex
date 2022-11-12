import ListGroup from 'react-bootstrap/ListGroup';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Container from 'react-bootstrap/esm/Container';

export default function HorizontalResponsiveExample(props) {
    const events = props.events;
    const len = events.length;

    let arrayOfEventArrays = [];
    let eventArray = [];

    // create array of event arrays, so that we can nice and neatly have a two dimensional mapping - 1. for each ListGroup, or row, and 2., for each item in the row
    for (let i = 0; i <= len; i++) {
        if ((i % 4 == 0 && i !=0) || i == len) {
            arrayOfEventArrays.push(eventArray);
            eventArray = [];
            eventArray.push(events[i]);
        } else {
            eventArray.push(events[i]);
        }
        
    }
    console.log(arrayOfEventArrays)
    return (
        <Container>
            <Row className="mt-5">
                <h2>Recommended - New Events!</h2>
            </Row>
            <Row>
                { arrayOfEventArrays.map((events, i) => (
                    <ListGroup key={i} horizontal='md' className="my-2">
                        {events.map((event) => (
                            <Col xs="3">
                                <ListGroup.Item variant='success' className='px-3 mb-2 ms-1 me-1 rounded-4' key={event.id}>{event.name}</ListGroup.Item>
                            </Col>)
                        )}
                    </ListGroup>
                    )   
                )}
            </Row>
        </Container>
    );
}
