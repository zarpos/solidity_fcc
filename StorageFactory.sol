// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;
    // We are creating a variable of type "SimpleStorage" (pay attention to how the two first letters are capitalized) and after the name of the variable "simpleStorage" (now this variable starts with low case letters)
    function createSimpleStorageContract() public {
        // how does storage factory know what simple storage looks like?
        SimpleStorage  simpleStorage = new SimpleStorage();
            // In this way, using the keyword "new", solidity knows we are going to deploy a new contract called SimpleStorage.
        simpleStorageArray.push(simpleStorage);
            // creo que está haciendo un array de las variables de simpleStorage para tener un registro de todos los contratos creados o modificados, como si fuese un log de versiones

    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // With these function, When we deploy a contract, first we are going to select the index of the array where we want to record the data, and after, the data we want to record.
        // Address
        // ABI - Application Binary Interface
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
        // The line up here has the exact same behaviour that the commented below, by coding like this we have a cleaner code.
        //SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
    }

    function sfGet (uint256 _simpleStorageIndex) public view returns(uint256) {
      return simpleStorageArray[_simpleStorageIndex].retrieve();
      // In this way what whe are going to do is that the function returns the object of the specific contract in the index of the array that we choose.

    }
}