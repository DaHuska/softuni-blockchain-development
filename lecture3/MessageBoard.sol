// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract MessageBoard {
    mapping(address user => string[]) public messages;

    function addMessage(string memory _message) external {
        messages[msg.sender].push(_message);
    }

    function previewMessage(string memory _message) external pure returns(string memory) {
        return string.concat("Draft: ", _message);
    }
}