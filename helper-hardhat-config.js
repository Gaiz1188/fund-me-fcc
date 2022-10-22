const networkConfig = {
    5: {
        name: "goerli",
        ethUsdPriceFeed: "0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e",
        blockConfirmation: 6,
    },
    137: {
        name: "polygon",
        ethUsdPriceFeed: "0x7bAC85A8a13A4BcD8abb3eB7d6b4d632c5a57676",
    },
    31337: {
        name: "hardhat",
        ethUsdPriceFeed: "0x7bAC85A8a13A4BcD8abb3eB7d6b4d632c5a57676",
        blockConfirmation: 1,
    },
}

const developmentChains = ["hardhat", "localhost"]
const DECIMAL = 8
const INITIAL_ANSWER = 200000000000

module.exports = {
    networkConfig,
    developmentChains,
    DECIMAL,
    INITIAL_ANSWER,
}
