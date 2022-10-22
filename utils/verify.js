//Verifying deployed contract
const { run } = require("hardhat")

async function verify(contractAddress, args) {
    console.log("Verifying Contract.....")
    console.log(contractAddress, args)
    try {
        await run("verify:verify", {
            address: contractAddress,
            constructorArguments: args,
        })
    } catch (e) {
        if (e.message.toLowerCase().includes("already verified")) {
            console.log("Already Verify")
        }
    }
}

module.exports = { verify }
