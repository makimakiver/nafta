// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
// ReentrancyGuard is used to prevent reentrancy attacks
// The module protects certain transactions from being re-entered
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";


contract NFTMarketPlace is ReentrancyGuard {

    uint256 public _itemIId;
    uint256 public _itemSold;
    uint256 public _itemPrice;
    address payable public owner;

    mapping(uint256 => uint256) public itemPrices;
   
   constructor() {
    owner = payable(msg.sender);
   }
//    definning what attributes the item will have
   struct Item {
    uint256 itemId;
    address nftContract;
    address payable seller;
    address payable owner;
    uint256 price;
    bool sold;
   }

   mapping(uint256 => Item) public idToMarketItem;

// the event will be used to emit the item created event
   event ItemCreated(
    uint256 indexed itemId,
    address indexed nftContract,
    address seller,
    address owner,
    uint256 price,
    bool sold
   );
   function createMarketItem(address nftContract, uint256 itemId, uint256 price) public payable nonReentrant {
    // creating mapping for the item prices
    // require the price to be greater than 0
    require(price > 0, "Price must be greater than 0");
    // incrementing the item id
    _itemIId++;
    uint256 new_itemId = _itemIId;

    // creating a new item
    idToMarketItem[new_itemId] = Item(
        new_itemId, 
        nftContract, 
        payable(msg.sender), 
        payable(address(0)), 
        price, 
        false
        );
        // transferring the ownership of the NFT from the seller to the marketplace
        IERC721(nftContract).transferFrom(msg.sender, address(this), itemId);
        // emitting the item created event
        emit ItemCreated(itemId, nftContract, msg.sender, address(0), price, false);
   }
//    creating a function to create a market sale
   function createMarketSale(address nftContract, uint256 itemId) public payable nonReentrant {
    // getting the price of the item
        uint256 price = idToMarketItem[itemId].price;
        uint256 tokenId = idToMarketItem[itemId].itemId;
        bool sold = idToMarketItem[itemId].sold;
        // we are asking the price is same as the asking price of the item
        require(msg.value == price, "Please submit the asking price in order to complete the purchase");
        // we are asking the item is not already sold
        require(sold == false, "Item already sold");

        // transferring the token from the marketplace to the buyer
        idToMarketItem[itemId].seller.transfer(msg.value);
        // transferring the ownership of the NFT from the marketplace to the buyer
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);

        idToMarketItem[itemId].owner = payable(msg.sender);
        // updating the sold status of the item
        _itemSold++;
        // updating the sold status of the item
        idToMarketItem[itemId].sold = true;
   }
   function fetchMarketItems() public view returns (Item[] memory) {
        uint256 itemCount = _itemIId;
        uint256 unsoldItemCount = _itemIId - _itemSold;
        uint256 currentIndex = 0;

        Item[] memory items = new Item[](unsoldItemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            if (idToMarketItem[i+1].sold == false) {
                uint256 currentId = i + 1;
                Item storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
   }
}
