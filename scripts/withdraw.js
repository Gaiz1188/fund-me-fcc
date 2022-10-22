const { getNamedAccounts } = require("hardhat")

async function main() {
    const { deployer } = await getNamedAccounts()
    const fundMe = await ethers.getContract("FundMe", deployer)
    console.log("Funding Contract...")
    const transactionResponse = await fundMe.withdraw()
    await transactionResponse.wait(1)
    const endingContractBalance = await fundMe.provider.getBalance(
        fundMe.address
    )
    const withdrawTransactionHash = transactionResponse.hash
    console.log("Withdraw Done !")
    console.log("============================================")
    console.log("Current Contract amount :", endingContractBalance.toString())
    console.log("Transaction Hash :", withdrawTransactionHash.toString())
    console.log("============================================")
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
