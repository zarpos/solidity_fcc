// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {
    // This contract just adds +5 to the number we have set as favourite number.

    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }

    function getPrice() public {
        // We are going to need:
        // ABI
        // Chainlink contract address in charge of giving as the actual price 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        // This is the address provided in the chainlink documentation to get the price of ETH/USD
        
    }

    function getConversionRate() public {}
