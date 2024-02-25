require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const { URL, PRIVATE_KEY, ETHERSCAN_API_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  defaultNetwork: "fuji",
  etherscan: {
    apiKey: {
      snowtrace: "snowtrace", // apiKey is not required, just set a placeholder
    },
    customChains: [
      {
        network: "snowtrace",
        chainId: 43113,
        urls: {
          apiURL:
            "https://api.routescan.io/v2/network/testnet/evm/43113/etherscan",
          browserURL: "https://testnet.snowtrace.io",
        },
      },
    ],
  },
  networks: {
    snowtrace: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      accounts: [process.env.PRIVATE_KEY],
    },
    fuji: {
      url: URL,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
};
// npx hardhat verify <contract address> <arguments> --network <network>

// $ npx hardhat run scripts/deploy.js --network fuji

// $ npx hardhat verify <YOUR TOKEN ADDRESS> --network fuji
