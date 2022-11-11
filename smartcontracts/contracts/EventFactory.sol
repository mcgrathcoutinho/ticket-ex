// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./TicketEx.sol";
import "./CloneFactory.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";

contract EventFactory is CloneFactory, Ownable {
    address[] private Events;
    mapping(address => bool) private devs;

    modifier isDev() {
        require(devs[_msgSender()], "Permission Denied");
        _;
    }

    address public baseExampleContract;

    constructor(address _baseExampleContract) {
        baseExampleContract = _baseExampleContract;
    }

    function cloneContract(
        string[] calldata fungibleTokenURI_,
        uint256[] calldata prices_,
        uint256[] calldata maxQuantity_,
        uint256 eventCheckInDeadline_,
        // address _owner,
        address _accounting,
        uint96 _royalty
    ) external isDev {
        TicketEx clonedContract = TicketEx(createClone(baseExampleContract));
        clonedContract.initialize(
            fungibleTokenURI_,
            prices_,
            maxQuantity_,
            eventCheckInDeadline_,
            // _owner,
            _accounting,
            _royalty
        );
        Events.push(address(clonedContract));
    }

    // 0xb6adF5cEf3060386B9251AaBC0f039d1a72C0554
    //     ["asdasd"],[1000],[11],1668989422,"0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "0xB6A8ece75F656376c770cEF30d2F546558431ACD",1000
    // 0xB6A8ece75F656376c770cEF30d2F546558431ACD
    function getContracts() external view returns (address[] memory) {
        return Events;
    }

    function splitter(address[] calldata payees, uint256[] calldata shares_)
        external
        isDev
        returns (address)
    {
        PaymentSplitter newSplitter = new PaymentSplitter(payees, shares_);
        return address(newSplitter);
    }

    // function ticketEx(string[] calldata fungibleTokenURI_,uint256[] calldata prices_, uint256[] calldata maxQuantity_, uint256 eventCheckInDeadline_, address _owner, address _accounting, uint96 _royalty) external isDev returns(address){
    //     TicketEx newEvent = new TicketEx();
    //     return address(newEvent);
    // }
    function addDev(address _dev) external onlyOwner {
        devs[_dev] = true;
    }
}
