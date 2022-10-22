// SPDX-License-Identifier: MIT
// Get fund from user
// withdraw funds
// set minimum funding value in USD

//Pragma statements

//Import statements

//Interfaces

//Libraries

//Contracts

pragma solidity ^0.8.17;

import "./PriceConverter.sol";
import "hardhat/console.sol"; //import console.log from hardhat to make us of it

error FundMe__NotOwner(string errorCode);

/** @title A contract for crown funding
 * @author Gaiz
 * @notice This contract is to demo a sample funding contract
 * @dev This implements price feeds as library
 */

contract FundMe {
    // Type Declarations
    using PriceConverter for uint256;

    // State variable
    //use constant if the variable is declared only once to save "gas"
    uint256 public constant MINIMUM_USD = 50 * 1e18; // 1 * 10 ** 18
    address[] private s_funders;
    mapping(address => uint256) private s_addressToAmountFunded;
    address private immutable i_owner;

    AggregatorV3Interface private s_priceFeed;

    modifier onlyOwner() {
        //  require (msg.sender == owner, "Sender is not owner");
        if (msg.sender != i_owner) {
            revert FundMe__NotOwner({errorCode: "Only Owner Can Perform This"});
        }
        _;
    }

    //constructor
    //receive function (if exists)
    //fallback function (if exists)
    //external
    //public
    //internal
    //private

    constructor(address priceFeedAddress) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    //whenever a trancation toward the contract automatically route it to func()
    //example : directly send from wallet / calling the contract itself
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    /**
     * @notice This contract is to demo a sample funding contract
     * @dev This implements price feeds as library
     */
    function fund() public payable {
        require(
            msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD,
            "You need to spend more ETH!"
        );
        s_funders.push(msg.sender);
        s_addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < s_funders.length;
            funderIndex++
        ) {
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        //reset the Array
        s_funders = new address[](0);

        //call - forward all gas or set gas , return bool

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call Failed");

        // //transfer - throw error
        // payable (msg.sender).transfer(address(this).balance);

        // //send - return bool
        // bool sendSuccess = payable (msg.sender).send(address(this).balance);
        // require (sendSuccess , "Sending Failed");
    }

    //cheaper way for withdraw function
    function cheaperWithdraw() public onlyOwner {
        address[] memory funders = s_funders;
        // mapping can't be in memory
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        require(success, "Call Failed");
    }

    function getPriceFeed() public view returns (AggregatorV3Interface) {
        return s_priceFeed;
    }

    //
    //    function getVersion() public view returns (uint256) {
    //        return s_priceFeed.version();
    //    }

    function getOwner() public view returns (address) {
        return i_owner;
    }

    function getFunder(uint256 index) public view returns (address) {
        return s_funders[index];
    }

    function getAddressToAmountFunded(address funder)
        public
        view
        returns (uint256)
    {
        return s_addressToAmountFunded[funder];
    }
}
