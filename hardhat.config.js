/**
 * @type import('hardhat/config').HardhatUserConfig
 */

const fs = require("fs");
const path = require("path");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
require("@nomicfoundation/hardhat-chai-matchers");
require("@nomicfoundation/hardhat-foundry");

let BBTestnet;
try {
  BBTestnet = JSON.parse(
    fs.readFileSync(path.join(__dirname, "./testnet.json")).toString().trim()
  );
} catch {}

module.exports = {
  defaultNetwork: BBTestnet ? "buildbear" : "localhost",

  networks: {
    hardhat: {},
    buildbear: {
      url: BBTestnet ? BBTestnet.rpcUrl : "",
    },
  },
  solidity: {
    compilers: [
      {
        version: "0.8.25",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  etherscan: {
    apiKey: {
      buildbear: "verifyContract",
    },
    customChains: [
      {
        network: "buildbear",
        chainId: BBTestnet ? BBTestnet.chainId : 0,
        urls: {
          apiURL: BBTestnet ? BBTestnet.verificationUrl : "",
          browserURL: BBTestnet ? BBTestnet.explorerUrl : "",
        },
      },
    ],
  },
  paths: {
    sources: "./contracts",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  mocha: {
    timeout: 20000000000,
  },
};
