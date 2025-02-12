// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Crowdfunding {
    uint256 public goalAmount = 100000000000000000000;
    uint256 endTime = block.timestamp + 604800;

    mapping(address contributor => uint256 contribution) public contributions;

    function contribute(uint256 _contribution) payable external {
        require(_contribution > 0 && _contribution < goalAmount);

        contributions[msg.sender] += _contribution;
        goalAmount -= _contribution;
    }

    function checkGoalReached() internal view returns(bool) {
        if (block.timestamp > endTime) {
            return false;
        }

        if (goalAmount >= 0) {
            return true;
        }

        return false;
    }

    function withdraw() external {
        require(block.timestamp > endTime);

        payable(msg.sender).transfer(contributions[msg.sender]);
        contributions[msg.sender] = 0;
    }
}