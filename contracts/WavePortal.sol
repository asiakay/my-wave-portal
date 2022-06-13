// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.3;
pragma experimental ABIEncoderV2;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    /* initialized to 0 */

    uint256 private seed;
    /* seed: helps generate a random number
    */
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
        console.log("Smarty contract has been constructed");
        /* setting the initial seed below */
        seed = (block.timestamp + block.difficulty) % 100;
        /* block.difficulty and block.timestamp are combined to create a random number. 
        block.difficulty: tells miners how hard the block will be to mine based on the transactions in the block.
        block.timestamp:the Unix timestamp that the block is being processed
        seed: will change every time a user sends a new wave. 
         */
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved.", msg.sender, _message);
        /* msg.sender is the address of the person who called the wave */
        /* _message is the message that user sends from the frontend */
        waves.push(Wave(msg.sender, _message, block.timestamp));
        /* where the wave data is stored in the array */
        seed = (block.difficulty + block.timestamp + seed) % 100;
        /* (above line) generated a new seed for the next user that sends a wave */
        console.log("Random # generated: %d", seed);
        /* (below line) giving a 50% chance that the user wins the prize */
        if (seed <= 50){
            console.log("%s won!", msg.sender);
            /* move placement of code for sending prize here */
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

        emit NewWave(msg.sender, block.timestamp, _message);
    }
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}