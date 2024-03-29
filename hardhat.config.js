require("@nomiclabs/hardhat-waffle");
require('@nomiclabs/hardhat-ethers');
require ("dotenv").config();
// imported and configured dotenv

module.exports = {
  solidity: "0.8.0",
  networks: {
    rinkeby: {
      url: process.env.STAGING_ALCHEMY_KEY,
      accounts: [process.env.PRIVATE_KEY],
    },
      mainnet: {
        chainId: 1,
        url: process.env.PROD_ALCHEMY_KEY,
        accounts: [process.env.PRIVATE_KEY],
      },
    },
};