import 'bootstrap/dist/css/bootstrap.css';
import Container from 'react-bootstrap/Container';
import EventCarousel from './EventCarousel';
import Navbar from './Navbar';

const events = [
    {
        id: 1,
        name: "ETHCRUNCH 2023",
        startDate: "2023-04-13 16:00:00PM",
        endDate: "2023-04-16 12:00:00PM",
        venue: "The Bunker",
        location: "Medellin, Colombia",
        imagePath: "eth"
    },
    {
        id: 2,
        name: "Rubber & Road",
        startDate: "2023-03-12 16:00:00PM ET",
        endDate: null,
        venue: "The Forest Point Fairground",
        location: "Silverstone, England",
        imagePath: "race"
    },
    {
        id: 3,
        name: "Ephemira Music Fest",
        startDate: "2023-07-01 17:00:00PM",
        endDate: null,
        venue: "Dock Beach",
        location: "Budva, Montenegro",
        imagePath: "concert"
    }
]

function Dashboard() {
  return (
    <Container>
        <Navbar/>
        <EventCarousel events={events}/>
    </Container>
  );
}

export { Dashboard };
