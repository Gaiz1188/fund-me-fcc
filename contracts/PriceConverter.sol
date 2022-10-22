/// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

//https://docs.chain.link/docs/data-feeds/price-feeds/api-reference/ chainlink  Data Feed API referrence

//import AggregatorV3 Interface from chainlink
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    //    function getVersion() internal view returns (uint) {
    //
    //        //Goerli testnet contract Address for get price =  0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
    //        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    //        return priceFeed.version();
    //    }

    function getPrice(AggregatorV3Interface priceFeed)
        internal
        view
        returns (uint256)
    {
        //ABi
        //Goerli testnet contract Address for get price =  0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

        /* AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);*/
        (, int256 answer, , , ) = priceFeed.latestRoundData(); //returned 4 arguement but we only take the 2nd arguement
        return uint256(answer * 10000000000); //returned value in 1e8 and multiply it with **10 to meet 1e18
    }

    function getConversionRate(
        uint256 ethAmout,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInUsd = (ethPrice * ethAmout) / 1e18;
        return ethAmountInUsd;
    }
}
