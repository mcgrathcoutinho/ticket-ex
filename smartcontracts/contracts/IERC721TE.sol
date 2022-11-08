// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

interface IERC721TE is IERC721, IERC721Receiver, IERC721Metadata {
    function punchTicket(uint256[] calldata tokenIds) external;

    event Punched(uint256 tokenId);
}
