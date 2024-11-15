// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract NonFungibleVoice is ERC721URIStorage, Ownable {
    // generating the token Ids by using the Counters library

    uint256 private _tokenIds;
    // create a constructor for the NFT contract
    // ownable command is used to set the owner of the contract. {} is used to initialize the contract
    constructor() ERC721("Potentially voice", "ART") Ownable(msg.sender) {}
    // create a function which will be used to mint the NFTs
    // minting function involves 5 steps:
    // 1. incrementing the token id
    // 2. creating a new item id
    // 3. minting the NFTs  
    // 4. setting the token URI
    // 5. returning the new item id
    function mint(string memory tokenURI) public onlyOwner returns (uint256) {
        _tokenIds++;

        uint newItemId = _tokenIds;
        // minting the NFTs
        _mint(msg.sender, newItemId);
        // setting the token URI
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIds;
    }
}
