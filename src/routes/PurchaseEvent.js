import Navbar from '../Navbar';
import ReactDOM from 'react-dom';
const Web3 = require('web3');

let account = null;
let contract = null;
const ABI = {};
const ADDRESS = "";

const walletConnectivity = async () => {
    if(window.ethereum) {
        await window.ethereum.send('eth_requestAccounts')
        window.web3 = new Web3(window.ethereum);

        let accounts = await Web3.eth.ethAccounts();
        account = accounts[0];
        ReactDOM.render(document.getElementById('wallet-address').textContent = account);

        contract = new Web3.eth.Contract(ABI, ADDRESS);

        ReactDOM.render(document.getElementById('mint').onclick = () => {
        contract.methods.safeMint(account).send({from:account,value:"10000000000000000"})
        })

        let totalSupply = await contract.methods.totalSupply().call();
        ReactDOM.render(document.getElementById('ttt').textContent = totalSupply);
    }              
}


export default function PurchaseTicket () {
    return (
        <div>
            <div className='event-details'>
                <br></br>
                <p>Event image</p><br></br>
                <p>Event Name</p><br></br>
                <p>Event Description</p><br></br>
                <p>Event Deadline</p><br></br>
                <p>Total supply left</p><br></br>
                <button id='book-tickets' onClick={walletConnectivity}>
                    Book Tickets
                </button> 
            </div>
        </div>
    )
}