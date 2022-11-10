import 'bootstrap/dist/css/bootstrap.css';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';

function Navbar() {
    return (
        <Row className="pt-4">
            <Col md={2}>
                <h2><em>TicketEx</em></h2>
            </Col>
            <Col md={6}>
                <Form className="d-flex">
                <Form.Control
                    type="search"
                    placeholder="Search for Movies, Events, Plays, Sports and Activities"
                    className="me-4"
                    aria-label="Search"
                />
                <Button variant="outline-success">Search</Button>
                </Form>
            </Col>
            <Col md={2} className="text-nowrap"><Button variant="outline-success">Create Event</Button></Col>
            <Col md={2} className="text-nowrap"><Button variant="outline-success">Purchase Ticket</Button></Col>
        </Row>
    );
}

export default Navbar;