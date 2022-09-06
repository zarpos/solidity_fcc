// SPDX-License-Identifier: MIT

// Receive Funds from other users
// It allows you to withdraw these funds only if you are the owner
// You can set a minimun amount of ETH to be fund calculated in USD

pragma solidity ^0.8.8;

import "./PriceConverter.sol";

// error NotOwner();
// The function in the upper line is to handle error messages and save some gas.

contract FundMe {
    using PriceConverter for uint256;
    // With this line and thanks to the library we are using the uint256 as an object or a class and this way apply functions as for example msg.value.getConversionRate();

    uint256 public constant minimunUSD = 50 * 1e18; // 1e18 is the same as 1 * 10 ** 18

    address[] public funders;
    // We create an array to save the address of all the funders
    mapping(address => uint256) public addressToAmountFunded;
    // We make an array to see the amount funded by each user.

    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
        // As the constructor is only executed once at the moment of the deploy. With these line we became the owners of the contract. ;)
    }

    function fund() public payable {
    // We want to establish a minimun amount of value in USD to be funded
    // 1. ¿How to send ETH to these contract? 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
    msg.value.getConversionRate(); // Is the same as getConversionRate(msg.value)
       require(msg.value.getConversionRate() >= minimunUSD, "Didn't send enough!!!"); // With these we are making to set the minimun amount to be funded, equal or greater than the variable "minimunUSD"
        // The code between parenthesis: The first argument is for selecting the minimun amount, and the second argument is for in case the sentence "require" fails, an error message will appear.
        // 18 decimals
        funders.push(msg.sender);
        // We add to the funders array, the wallet address of the user making the transaction.
        addressToAmountFunded[msg.sender] = msg.value;
        // Here we are creating the relation between the amount of ETH funded asociated with the wallet address.
    
    }

    function withdraw() public onlyOwner {   // With the onlyOwner part we are adding the modifier that is like a require. 
       /* This function is going to let us withdraw the money but first set the amount to 0 of each user funding.
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
           address funder = funders[funderIndex];
           addressToAmountFunded[funder] = 0;
           We set the amount of every transaction made by the users to 0, because in the contract will no longer be any money.
        } */
        
        // Instead of making a for loop, we can just reset it.
        funders = new address[] (0);
        // Reset the array
        (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}("");
        // This function returns two variables, is that the reason why at the left part we add the bool part and  after, the "bytes" part.3
        // As we don't need information about the bytes part, we comment it.
        require(callSuccess, "Call failed");
    }
    
    modifier onlyOwner {
        require(msg.sender == i_owner, "Sender is not owner!!!"); // Important to use the "=" symbol twice.
      //  if(msg.sender != i_owner) { revert NotOwner();}  // It's the exact same thing as the line up here but this way(the commented line) is more gas eficient.   
        _; 
        // The underscore is to execute all the code below afterwards we check the require, this way, we first verify the require and if it's correct we execute the code.
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}

   


   