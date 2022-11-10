import React, { useState, useEffect } from 'react';
import ReactDOM from 'react-dom';
// import './mint.css';

export default function CreateEvent(){
    const [name, setName] = useState()
    const [noOfTickets, setNoOfTickets] = useState()
    const [description, setDescription] = useState()

    useEffect(() => {
        console.log({name, noOfTickets, description})
    }, [name, noOfTickets, description])

    const createEventBtnHandler = async() => {
        // 1. Upload image to IPFS
        // 2. Call createEvent method on smart contract
        // await contract.createEvent(name, description, noOfTickets, ipfsImageUrl)
    }

    return <div>
         <h1 id="ticketex">TicketEx</h1>
            <video autoplay muted loop id="myVideo">
                <source src="./background-video.mov" type="video/mp4"/>
            </video>
            <form>
            <h1 id="create-new-event">Create New Event</h1>
            <ol class="main-details">
                <li id="nameofevent">Name of Event
                    <br/><input id="textbox1" type="text" value={name} onChange={(e) => setName(e.target.value)}/>
                </li>
                <br/>
                <li id="ticketquantity">Number of Tickets
                    <br/><input id="textbox2" type="number" value={noOfTickets} onChange={(e) => setNoOfTickets(e.target.value)}/>
                </li>
                <br/>
                <li id="description">Description
                    <br/><input id="textbox3" type="text" value={description} onChange={(e) => setDescription(e.target.value)} />
                </li>
            <li>
            <p>Event Image</p>
            {/* <button class="upload-file"><img src="./bg-image-input.webp"/> */}
                <input id="upload-button-extend" type="file"/>
            {/* </button> */}
            </li>
            </ol>
            <br/>
            <br/>
            <button id="mint" onClick={createEventBtnHandler}>Create Event</button>
            </form>
        </div>
}