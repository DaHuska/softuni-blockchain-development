// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

struct Voter {
    bool hasVoted;
    uint256 choice;
}

contract Voting {
    mapping(address voter => Voter) votes;

    function registerVote(uint256 _candidate) external {
        require(votes[msg.sender].hasVoted == false);

        votes[msg.sender] = Voter({
            hasVoted: true,
            choice: _candidate
        });
    }

    function getVoter(address _voter) external view returns(bool, uint256) {
        return (votes[_voter].hasVoted, votes[_voter].choice);
    }
}