// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    /* initialized to 0 */
    event NewWave(address indexed from, uint256 timestamp, string message);
    /* an event is an inheritable member of a contract. An event is emitted, it stores the arguments passed in transaction logs */
    struct Wave {
        address waver;
        /* the address of the user who sent the wave */
        string message;
        /* the message the user sent */
        uint256 timestamp;
        /* the timestamp of when the user waved */
    }
    Wave[] waves;
    /* waves variable allows storage of an array of structs. It holds the wave that users send */
    constructor() payable {
        console.log("Smarty contract");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved.", msg.sender, _message);
        /* msg.sender is the address of the person who called the wave */
        /* _message is the message that user sends from the frontend */
        waves.push(Wave(msg.sender, _message, block.timestamp));
        /* where the wave data is stored in the array */
        emit NewWave(msg.sender, block.timestamp, _message);
        /* outputs the event */
        uint256 prizeAmount = 0.0001 ether;
        /* initiating a prize amount with the Solidity keyword ether */
        require(
            /* if contract is not funded with a high enough balance to pay out, */
            /* then require will kill the transaction */
            prizeAmount <= address(this).balance,
            /* address(this).balance is the balance of the contract itself */
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        /* (msg.sender).call{value: prizeAmount}("") is the where the money is sent */
        /* value passed through the transaction is the prizeAmount */
        require(success, "Failed to withdraw money from contract.");
        /* require(success verifies that the transaction was a success */
    }
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}