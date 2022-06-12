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
    constructor() {
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
    }
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}