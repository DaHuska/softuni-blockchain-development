// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract PaymentProcessor {
    mapping(address => uint256) balances;
    mapping(address => uint256[]) payments;

    function receivePayment(uint256 _payment) payable external {
        require(balances[msg.sender] >= _payment);

        balances[msg.sender] -= _payment;
        payments[msg.sender].push(_payment);
    }

    function checkBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function refundPayment() internal virtual {

    }
}

contract Merchant is PaymentProcessor {
    function refundPayment() internal override {
        require(payments[msg.sender][0] > 0);

        // remove payment from array
        balances[msg.sender] += payments[msg.sender][0];
    }
}