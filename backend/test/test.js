const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), "ether");
}

describe('NFTMarketplace', () => {

  it('should create and save the NFT asset', async () => {
    const NFT_Asset = await ethers.getContractFactory("NonFungibleVoice");
    const nft = await NFT_Asset.deploy();
    await nft.deployed();

    expect(nft.address).to.be.properAddress;
    console.log("NFT deployed to:", nft.address);
  })
})

// if you want to make a smart contract code, you have to look at the openzeppelin library on github.