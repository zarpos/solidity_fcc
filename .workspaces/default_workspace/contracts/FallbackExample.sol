// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    // Fallback function must be declared as external.
    fallback() external payable {
        result = 1;
    }

    // receive function also must be declared as external
    receive() external payable {
        result = 2;
    }
}

    // Receive and Fallback explanation:
    //
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()