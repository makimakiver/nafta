require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({path: ".env"});

const ALCHEMY_MAINNET_RPC_URL = process.env.ALCHEMY_MAINNET_RPC_URL;


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.27",
  networks: {
    mainnet: {
      url: ALCHEMY_MAINNET_RPC_URL,
    },
  },
};
