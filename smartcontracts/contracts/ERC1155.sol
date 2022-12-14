// // SPDX-License-Identifier: MIT

// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
// import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
// import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
// import "@openzeppelin/contracts/token/common/ERC2981.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Address.sol";
// import "@openzeppelin/contracts/utils/Context.sol";

// // import "@chainlink/contracts/src/v0.8/VRFV2WrapperConsumerBase.sol";

// contract ERC1155 is Context, ERC165, IERC1155, ERC2981, Ownable {
//     using Address for address;

//     // Mapping from token ID to account balances
//     mapping(uint256 => mapping(address => uint256)) private _balances;

//     //an array of addresses that attended/checkedIn
//     address[] public attendees;

//     //an array of unique tokenURIs to be assigned post checkin
//     string[] private _tokenURIs;

//     //an array of unique tokenURI quantities to be assigned post checkin
//     uint256[] private _tokenURIQuantities;

//     // array1[]
//     // array2[]
//     // checking
//     // array1.push(attendee)
//     // array2.push(tokenURI)
//     // Mapping from token ID to attendees
//     mapping(uint256 => mapping(address => uint256)) private _attendees;

//     // Array for tokenId to _maxQuantity
//     uint256[] private _maxQuantity;

//     //Array for tokenSupply
//     uint256[] private _supply;

//     // Array for tokenId to _prices
//     uint256[] private _prices;

//     // Array for tokenId to _prices
//     // address[][] private _attendees;

//     // Mapping from account to operator approvals
//     mapping(address => mapping(address => bool)) private _operatorApprovals;

//     // Used as the URI for all token types
//     string[] private _fungibleTokenURI;
//     string[] private _nonFungibleTokenURI;

//     string private _uri;

//     uint256 public eventCheckInDeadline;

//     uint256 private randNonce = 0;

//     event CheckedIn(address attendee, uint256[] _tokenIds, uint256[] _qty);

//     /**
//      * @dev See {_setURI}.
//      */
//     constructor(
//         string[] memory fungibleTokenURI_,
//         string[] memory nonFungibleTokenURI_,
//         uint256[] memory prices_,
//         uint256[] memory maxQuantity_,
//         uint256 eventCheckInDeadline_
//     ) {
//         _fungibleTokenURI = fungibleTokenURI_;
//         _nonFungibleTokenURI = nonFungibleTokenURI_;
//         _prices = prices_;
//         _maxQuantity = maxQuantity_;
//         _supply = maxQuantity_;
//         eventCheckInDeadline = eventCheckInDeadline_;
//     }

//     function setRoyaltyInfo(address receiver, uint96 feeBasisPoints)
//         external
//         onlyOwner
//     {
//         _setDefaultRoyalty(receiver, feeBasisPoints);
//     }

//     function buyTickets(uint256[] calldata _ticketIds, uint256[] calldata _qty)
//         external
//         payable
//     {
//         require(_ticketIds.length == _qty.length, "Invalid input");
//         uint256 _totalAmount = 0;

//         for (uint256 i = 0; i < _ticketIds.length; i++) {
//             require(
//                 _balances[_ticketIds[i]][msg.sender] + _qty[i] <=
//                     _maxQuantity[i],
//                 "Not enough tickets left"
//             );
//             // _balances[_ticketIds[i]][msg.sender] += _qty[i];
//             _totalAmount += _prices[_ticketIds[i]] * _qty[i];
//         }
//         require(msg.value == _totalAmount, "Invalid amount");
//         _mintBatch(_msgSender(), _ticketIds, _qty, "");
//         for (uint256 i = 0; i < _ticketIds.length; i++) {
//             _supply[_ticketIds[i]] += _qty[_ticketIds[i]];
//         }
//     }

//     function randMod(uint _modulus) internal returns (uint) {
//         // increase nonce
//         randNonce++;
//         return
//             uint(
//                 keccak256(
//                     abi.encodePacked(block.timestamp, msg.sender, randNonce)
//                 )
//             ) % _modulus;
//     }

//     function checkIn(uint256[] calldata _ticketId, uint256[] calldata _qty)
//         external
//     {
//         require(
//             block.timestamp < eventCheckInDeadline,
//             "Check in deadline has passed"
//         );
//         require(_ticketId.length == _qty.length, "Invalid input");
//         for (uint256 i = 0; i < _ticketId.length; i++) {
//             require(
//                 _balances[_ticketId[i]][msg.sender] - _qty[i] >= 0,
//                 "You don't have enough tickets"
//             );
//         }
//         // _safeBatchTransferFrom(_msgSender(), address(this), _ticketId, _qty);
//         for (uint256 i = 0; i < _ticketId.length; i++) {
//             attendees.push(_msgSender());
//             _tokenURIs.push(randMod(_nonFungibleTokenURI.length));
//         }
//     }

//     function getBaseTokenURI() public view returns (string memory) {
//         return _uri;
//     }

//     function setBaseTokenURI(string memory newuri) public {
//         _uri = newuri;
//     }

//     function setNonFungibleTokenURI(string[] calldata newuri) public {
//         _nonFungibleTokenURI = newuri;
//     }

//     function getTokenURI(string memory tokenId) public returns (string memory) {
//         return _getTokenURI;
//     }

//     function _getTokenURI(string memory tokenId) internal {
//         if (block.timestamp > _eventCheckInDeadline) {
//             return _nonFungibleTokenURI[_tokenURIs[tokenId]];
//         } else {
//             return _fungibleTokenURI[tokenId];
//         }
//     }

//     //callable by anyone as the address is hardcoded
//     function withdraw() public {
//         (bool success, ) = _accounting.call{value: address(this).balance}("");
//         require(success, "Failed to send to Simono.");
//     }

//     // function onERC1155Received(
//     //     address _operator,
//     //     address _from,
//     //     uint256 _tokenId,
//     //     uint256 _amount,
//     //     bytes memory
//     // ) public virtual override returns (bytes4) {

//     //     return this.onERC1155Received.selector;
//     // }

//     // function onERC1155BatchReceived(
//     //     address,
//     //     address,
//     //     uint256[] memory,
//     //     uint256[] memory,
//     //     bytes memory
//     // ) public virtual override returns (bytes4) {
//     //     return this.onERC1155BatchReceived.selector;
//     // }

//     // function _checkIn(
//     //     address from,
//     //     uint256[] memory ids,
//     //     uint256[] memory amounts
//     // ) internal virtual {
//     //     require(from != address(0), "ERC1155: burn from the zero address");
//     //     require(
//     //         ids.length == amounts.length,
//     //         "ERC1155: ids and amounts length mismatch"
//     //     );

//     //     for (uint256 i = 0; i < ids.length; i++) {
//     //         uint256 id = ids[i];
//     //         uint256 amount = amounts[i];

//     //         uint256 fromBalance = _balances[id][from];
//     //         require(
//     //             fromBalance >= amount,
//     //             "ERC1155: burn amount exceeds balance"
//     //         );
//     //         unchecked {
//     //             _balances[id][from] = fromBalance - amount;
//     //         }
//     //     }
//     //     emit CheckedIn(_msgSender(), ids, amounts);
//     // }

//     /**
//      * @dev See {IERC165-supportsInterface}.
//      */
//     function supportsInterface(bytes4 interfaceId)
//         public
//         view
//         virtual
//         override(ERC165, IERC165)
//         returns (bool)
//     {
//         return
//             interfaceId == type(IERC1155).interfaceId ||
//             super.supportsInterface(interfaceId);
//     }

//     /**
//      * @dev See {IERC1155MetadataURI-uri}.
//      *
//      * This implementation returns the same URI for *all* token types. It relies
//      * on the token type ID substitution mechanism
//      * https://eips.ethereum.org/EIPS/eip-1155#metadata[defined in the EIP].
//      *
//      * Clients calling this function must replace the `\{id\}` substring with the
//      * actual token type ID.
//      */
//     // function uri(uint256) public view virtual override returns (string memory) {
//     //     return _uri;
//     // }

//     /**
//      * @dev See {IERC1155-balanceOf}.
//      *
//      * Requirements:
//      *
//      * - `account` cannot be the zero address.
//      */
//     function balanceOf(address account, uint256 id)
//         public
//         view
//         virtual
//         override
//         returns (uint256)
//     {
//         require(
//             account != address(0),
//             "ERC1155: address zero is not a valid owner"
//         );
//         return _balances[id][account];
//     }

//     /**
//      * @dev See {IERC1155-balanceOfBatch}.
//      *
//      * Requirements:
//      *
//      * - `accounts` and `ids` must have the same length.
//      */
//     function balanceOfBatch(address[] memory accounts, uint256[] memory ids)
//         public
//         view
//         virtual
//         override
//         returns (uint256[] memory)
//     {
//         require(
//             accounts.length == ids.length,
//             "ERC1155: accounts and ids length mismatch"
//         );

//         uint256[] memory batchBalances = new uint256[](accounts.length);

//         for (uint256 i = 0; i < accounts.length; ++i) {
//             batchBalances[i] = balanceOf(accounts[i], ids[i]);
//         }

//         return batchBalances;
//     }

//     /**
//      * @dev See {IERC1155-setApprovalForAll}.
//      */
//     function setApprovalForAll(address operator, bool approved)
//         public
//         virtual
//         override
//     {
//         _setApprovalForAll(_msgSender(), operator, approved);
//     }

//     /**
//      * @dev See {IERC1155-isApprovedForAll}.
//      */
//     function isApprovedForAll(address account, address operator)
//         public
//         view
//         virtual
//         override
//         returns (bool)
//     {
//         return _operatorApprovals[account][operator];
//     }

//     /**
//      * @dev See {IERC1155-safeTransferFrom}.
//      */
//     function safeTransferFrom(
//         address from,
//         address to,
//         uint256 id,
//         uint256 amount,
//         bytes memory data
//     ) public virtual override {
//         require(
//             from == _msgSender() || isApprovedForAll(from, _msgSender()),
//             "ERC1155: caller is not token owner or approved"
//         );
//         _safeTransferFrom(from, to, id, amount, data);
//     }

//     /**
//      * @dev See {IERC1155-safeBatchTransferFrom}.
//      */
//     function safeBatchTransferFrom(
//         address from,
//         address to,
//         uint256[] memory ids,
//         uint256[] memory amounts,
//         bytes memory data
//     ) public virtual override {
//         require(
//             from == _msgSender() || isApprovedForAll(from, _msgSender()),
//             "ERC1155: caller is not token owner or approved"
//         );
//         _safeBatchTransferFrom(from, to, ids, amounts, data);
//     }

//     /**
//      * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
//      *
//      * Emits a {TransferSingle} event.
//      *
//      * Requirements:
//      *
//      * - `to` cannot be the zero address.
//      * - `from` must have a balance of tokens of type `id` of at least `amount`.
//      * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
//      * acceptance magic value.
//      */
//     function _safeTransferFrom(
//         address from,
//         address to,
//         uint256 id,
//         uint256 amount,
//         bytes memory data
//     ) internal virtual {
//         require(to != address(0), "ERC1155: transfer to the zero address");

//         address operator = _msgSender();
//         uint256[] memory ids = _asSingletonArray(id);
//         uint256[] memory amounts = _asSingletonArray(amount);

//         _beforeTokenTransfer(operator, from, to, ids, amounts, data);

//         uint256 fromBalance = _balances[id][from];
//         require(
//             fromBalance >= amount,
//             "ERC1155: insufficient balance for transfer"
//         );
//         unchecked {
//             _balances[id][from] = fromBalance - amount;
//         }
//         _balances[id][to] += amount;

//         emit TransferSingle(operator, from, to, id, amount);

//         _afterTokenTransfer(operator, from, to, ids, amounts, data);

//         _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);
//     }

//     /**
//      * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_safeTransferFrom}.
//      *
//      * Emits a {TransferBatch} event.
//      *
//      * Requirements:
//      *
//      * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
//      * acceptance magic value.
//      */
//     function _safeBatchTransferFrom(
//         address from,
//         address to,
//         uint256[] memory ids,
//         uint256[] memory amounts,
//         bytes memory data
//     ) internal virtual {
//         require(
//             ids.length == amounts.length,
//             "ERC1155: ids and amounts length mismatch"
//         );
//         require(to != address(0), "ERC1155: transfer to the zero address");

//         address operator = _msgSender();

//         _beforeTokenTransfer(operator, from, to, ids, amounts, data);

//         for (uint256 i = 0; i < ids.length; ++i) {
//             uint256 id = ids[i];
//             uint256 amount = amounts[i];

//             uint256 fromBalance = _balances[id][from];
//             require(
//                 fromBalance >= amount,
//                 "ERC1155: insufficient balance for transfer"
//             );
//             unchecked {
//                 _balances[id][from] = fromBalance - amount;
//             }
//             _balances[id][to] += amount;
//         }

//         emit TransferBatch(operator, from, to, ids, amounts);

//         _afterTokenTransfer(operator, from, to, ids, amounts, data);

//         _doSafeBatchTransferAcceptanceCheck(
//             operator,
//             from,
//             to,
//             ids,
//             amounts,
//             data
//         );
//     }

//     /**
//      * @dev Sets a new URI for all token types, by relying on the token type ID
//      * substitution mechanism
//      * https://eips.ethereum.org/EIPS/eip-1155#metadata[defined in the EIP].
//      *
//      * By this mechanism, any occurrence of the `\{id\}` substring in either the
//      * URI or any of the amounts in the JSON file at said URI will be replaced by
//      * clients with the token type ID.
//      *
//      * For example, the `https://token-cdn-domain/\{id\}.json` URI would be
//      * interpreted by clients as
//      * `https://token-cdn-domain/000000000000000000000000000000000000000000000000000000000004cce0.json`
//      * for token type ID 0x4cce0.
//      *
//      * See {uri}.
//      *
//      * Because these URIs cannot be meaningfully represented by the {URI} event,
//      * this function emits no events.
//      */
//     // function _setURI(string memory newuri) internal virtual {
//     //     _uri = newuri;
//     // }

//     /**
//      * @dev Creates `amount` tokens of token type `id`, and assigns them to `to`.
//      *
//      * Emits a {TransferSingle} event.
//      *
//      * Requirements:
//      *
//      * - `to` cannot be the zero address.
//      * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
//      * acceptance magic value.
//      */
//     function _mint(
//         address to,
//         uint256 id,
//         uint256 amount,
//         bytes memory data
//     ) internal virtual {
//         require(to != address(0), "ERC1155: mint to the zero address");

//         address operator = _msgSender();
//         uint256[] memory ids = _asSingletonArray(id);
//         uint256[] memory amounts = _asSingletonArray(amount);

//         _beforeTokenTransfer(operator, address(0), to, ids, amounts, data);

//         _balances[id][to] += amount;
//         emit TransferSingle(operator, address(0), to, id, amount);

//         _afterTokenTransfer(operator, address(0), to, ids, amounts, data);

//         _doSafeTransferAcceptanceCheck(
//             operator,
//             address(0),
//             to,
//             id,
//             amount,
//             data
//         );
//     }

//     /**
//      * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_mint}.
//      *
//      * Emits a {TransferBatch} event.
//      *
//      * Requirements:
//      *
//      * - `ids` and `amounts` must have the same length.
//      * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
//      * acceptance magic value.
//      */
//     function _mintBatch(
//         address to,
//         uint256[] memory ids,
//         uint256[] memory amounts,
//         bytes memory data
//     ) internal virtual {
//         require(to != address(0), "ERC1155: mint to the zero address");
//         require(
//             ids.length == amounts.length,
//             "ERC1155: ids and amounts length mismatch"
//         );

//         address operator = _msgSender();

//         _beforeTokenTransfer(operator, address(0), to, ids, amounts, data);

//         for (uint256 i = 0; i < ids.length; i++) {
//             _balances[ids[i]][to] += amounts[i];
//         }

//         emit TransferBatch(operator, address(0), to, ids, amounts);

//         _afterTokenTransfer(operator, address(0), to, ids, amounts, data);

//         _doSafeBatchTransferAcceptanceCheck(
//             operator,
//             address(0),
//             to,
//             ids,
//             amounts,
//             data
//         );
//     }

//     /**
//      * @dev Destroys `amount` tokens of token type `id` from `from`
//      *
//      * Emits a {TransferSingle} event.
//      *
//      * Requirements:
//      *
//      * - `from` cannot be the zero address.
//      * - `from` must have at least `amount` tokens of token type `id`.
//      */
//     function _burn(
//         address from,
//         uint256 id,
//         uint256 amount
//     ) internal virtual {
//         require(from != address(0), "ERC1155: burn from the zero address");

//         address operator = _msgSender();
//         uint256[] memory ids = _asSingletonArray(id);
//         uint256[] memory amounts = _asSingletonArray(amount);

//         _beforeTokenTransfer(operator, from, address(0), ids, amounts, "");

//         uint256 fromBalance = _balances[id][from];
//         require(fromBalance >= amount, "ERC1155: burn amount exceeds balance");
//         unchecked {
//             _balances[id][from] = fromBalance - amount;
//         }

//         emit TransferSingle(operator, from, address(0), id, amount);

//         _afterTokenTransfer(operator, from, address(0), ids, amounts, "");
//     }

//     /**
//      * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_burn}.
//      *
//      * Emits a {TransferBatch} event.
//      *
//      * Requirements:
//      *
//      * - `ids` and `amounts` must have the same length.
//      */
//     function _burnBatch(
//         address from,
//         uint256[] memory ids,
//         uint256[] memory amounts
//     ) internal virtual {
//         require(from != address(0), "ERC1155: burn from the zero address");
//         require(
//             ids.length == amounts.length,
//             "ERC1155: ids and amounts length mismatch"
//         );

//         address operator = _msgSender();

//         _beforeTokenTransfer(operator, from, address(0), ids, amounts, "");

//         for (uint256 i = 0; i < ids.length; i++) {
//             uint256 id = ids[i];
//             uint256 amount = amounts[i];

//             uint256 fromBalance = _balances[id][from];
//             require(
//                 fromBalance >= amount,
//                 "ERC1155: burn amount exceeds balance"
//             );
//             unchecked {
//                 _balances[id][from] = fromBalance - amount;
//             }
//         }

//         emit TransferBatch(operator, from, address(0), ids, amounts);

//         _afterTokenTransfer(operator, from, address(0), ids, amounts, "");
//     }

//     /**
//      * @dev Approve `operator` to operate on all of `owner` tokens
//      *
//      * Emits an {ApprovalForAll} event.
//      */
//     function _setApprovalForAll(
//         address owner,
//         address operator,
//         bool approved
//     ) internal virtual {
//         require(owner != operator, "ERC1155: setting approval status for self");
//         _operatorApprovals[owner][operator] = approved;
//         emit ApprovalForAll(owner, operator, approved);
//     }

//     /**
//      * @dev Hook that is called before any token transfer. This includes minting
//      * and burning, as well as batched variants.
//      *
//      * The same hook is called on both single and batched variants. For single
//      * transfers, the length of the `ids` and `amounts` arrays will be 1.
//      *
//      * Calling conditions (for each `id` and `amount` pair):
//      *
//      * - When `from` and `to` are both non-zero, `amount` of ``from``'s tokens
//      * of token type `id` will be  transferred to `to`.
//      * - When `from` is zero, `amount` tokens of token type `id` will be minted
//      * for `to`.
//      * - when `to` is zero, `amount` of ``from``'s tokens of token type `id`
//      * will be burned.
//      * - `from` and `to` are never both zero.
//      * - `ids` and `amounts` have the same, non-zero length.
//      *
//      * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
//      */
//     function _beforeTokenTransfer(
//         address operator,
//         address from,
//         address to,
//         uint256[] memory ids,
//         uint256[] memory amounts,
//         bytes memory data
//     ) internal virtual {}

//     /**
//      * @dev Hook that is called after any token transfer. This includes minting
//      * and burning, as well as batched variants.
//      *
//      * The same hook is called on both single and batched variants. For single
//      * transfers, the length of the `id` and `amount` arrays will be 1.
//      *
//      * Calling conditions (for each `id` and `amount` pair):
//      *
//      * - When `from` and `to` are both non-zero, `amount` of ``from``'s tokens
//      * of token type `id` will be  transferred to `to`.
//      * - When `from` is zero, `amount` tokens of token type `id` will be minted
//      * for `to`.
//      * - when `to` is zero, `amount` of ``from``'s tokens of token type `id`
//      * will be burned.
//      * - `from` and `to` are never both zero.
//      * - `ids` and `amounts` have the same, non-zero length.
//      *
//      * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
//      */
//     function _afterTokenTransfer(
//         address operator,
//         address from,
//         address to,
//         uint256[] memory ids,
//         uint256[] memory amounts,
//         bytes memory data
//     ) internal virtual {}

//     function _doSafeTransferAcceptanceCheck(
//         address operator,
//         address from,
//         address to,
//         uint256 id,
//         uint256 amount,
//         bytes memory data
//     ) private {
//         if (to.isContract()) {
//             try
//                 IERC1155Receiver(to).onERC1155Received(
//                     operator,
//                     from,
//                     id,
//                     amount,
//                     data
//                 )
//             returns (bytes4 response) {
//                 if (response != IERC1155Receiver.onERC1155Received.selector) {
//                     revert("ERC1155: ERC1155Receiver rejected tokens");
//                 }
//             } catch Error(string memory reason) {
//                 revert(reason);
//             } catch {
//                 revert("ERC1155: transfer to non-ERC1155Receiver implementer");
//             }
//         }
//     }

//     function _doSafeBatchTransferAcceptanceCheck(
//         address operator,
//         address from,
//         address to,
//         uint256[] memory ids,
//         uint256[] memory amounts,
//         bytes memory data
//     ) private {
//         if (to.isContract()) {
//             try
//                 IERC1155Receiver(to).onERC1155BatchReceived(
//                     operator,
//                     from,
//                     ids,
//                     amounts,
//                     data
//                 )
//             returns (bytes4 response) {
//                 if (
//                     response != IERC1155Receiver.onERC1155BatchReceived.selector
//                 ) {
//                     revert("ERC1155: ERC1155Receiver rejected tokens");
//                 }
//             } catch Error(string memory reason) {
//                 revert(reason);
//             } catch {
//                 revert("ERC1155: transfer to non-ERC1155Receiver implementer");
//             }
//         }
//     }

//     function _asSingletonArray(uint256 element)
//         private
//         pure
//         returns (uint256[] memory)
//     {
//         uint256[] memory array = new uint256[](1);
//         array[0] = element;

//         return array;
//     }
// }
