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

    function refundPayment(uint256 _transaction) payable public virtual {
        require(payments[msg.sender][_transaction] > 0);
        // remove payment from array
        balances[msg.sender] += payments[msg.sender][_transaction];
        payments[msg.sender][_transaction] = payments[msg.sender][payments[msg.sender].length - 1];
        payments[msg.sender].pop();
    }
}

contract Merchant is PaymentProcessor {
    function refundPayment(uint256 _transaction) payable public override {
        uint256 bonus = payments[msg.sender][_transaction] / 100;
        uint256 refundAmount = payments[msg.sender][_transaction] + bonus;

        balances[msg.sender] += refundAmount;
        payments[msg.sender][_transaction] = payments[msg.sender][payments[msg.sender].length - 1];
        payments[msg.sender].pop();
    }
}