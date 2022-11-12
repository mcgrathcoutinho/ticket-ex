import 'bootstrap/dist/css/bootstrap.css';
import Container from 'react-bootstrap/Container';
import EventCarousel from './../EventCarousel';
import EventsList from './../EventsList';

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
    },
    {
        id: 4,
        name: "Rubber & Road - 2!",
        startDate: "2023-03-12 16:00:00PM ET",
        endDate: null,
        venue: "The Forest Point Fairground",
        location: "Silverstone, England",
        imagePath: "race"
    },
    {
        id: 5,
        name: "Ephemira Music Fest",
        startDate: "2023-07-01 17:00:00PM",
        endDate: null,
        venue: "Dock Beach",
        location: "Budva, Montenegro",
        imagePath: "concert"
    },
    {
        id: 6,
        name: "Rubber & Road - 3!",
        startDate: "2023-03-12 16:00:00PM ET",
        endDate: null,
        venue: "The Forest Point Fairground",
        location: "Silverstone, England",
        imagePath: "race"
    },
    {
        id: 7,
        name: "Ephemira Music Fest - 2!",
        startDate: "2023-07-01 17:00:00PM",
        endDate: null,
        venue: "Dock Beach",
        location: "Budva, Montenegro",
        imagePath: "concert"
    },
    {
        id: 8,
        name: "Rubber & Road - 4!",
        startDate: "2023-03-12 16:00:00PM ET",
        endDate: null,
        venue: "The Forest Point Fairground",
        location: "Silverstone, England",
        imagePath: "race"
    },
    {
        id: 9,
        name: "Ephemira Music Fest - 3!",
        startDate: "2023-07-01 17:00:00PM",
        endDate: null,
        venue: "Dock Beach",
        location: "Budva, Montenegro",
        imagePath: "concert"
    },
    {
        id: 10,
        name: "Rubber & Road - 5!",
        startDate: "2023-03-12 16:00:00PM ET",
        endDate: null,
        venue: "The Forest Point Fairground",
        location: "Silverstone, England",
        imagePath: "race"
    },
    {
        id: 11,
        name: "Ephemira Music Fest - 3!",
        startDate: "2023-07-01 17:00:00PM",
        endDate: null,
        venue: "Dock Beach",
        location: "Budva, Montenegro",
        imagePath: "concert"
    }
]

export default function Dashboard() {
  return (
    <div>
        <Container>
            <EventCarousel events={events}/>
            <EventsList events={events}/>
        </Container>
    </div>
  );
}
