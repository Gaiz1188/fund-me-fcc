//import
const { network } = require("hardhat")
const { networkConfig, developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../utils/verify")
require("dotenv").config()

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId

    // chainId === 5 ? console.log("Goerli") : console.log("unknown")
    let ethUsdPriceFeedAddress
    if (developmentChains.includes(network.name)) {
        const ethUsdAggregator = await deployments.get("MockV3Aggregator")
        ethUsdPriceFeedAddress = ethUsdAggregator.address
    } else {
        ethUsdPriceFeedAddress = networkConfig[chainId]["ethUsdPriceFeed"]
    }

    const args = [ethUsdPriceFeedAddress]
    const fundMe = await deploy("FundMe", {
        from: deployer,
        args: args, //put priceFeed address
        log: true,
        waitConfirmations: networkConfig[chainId].blockConfirmation || 1,
        // waitConfirmations : network.config.blockConfirmation || 0
    })

    if (
        !developmentChains.includes(network.name) &&
        process.env.ETHERSCAN_API
    ) {
        await verify(fundMe.address, args)
    }

    log("---------------------------------------------")
    log(chainId)
    log(ethUsdPriceFeedAddress)
    log(deployer)
    log(args)
    log("---------------------------------------------")
}

module.exports.tags = ["all", "fundMe"]
