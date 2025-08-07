// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract PaymentProcessor {
    mapping(address => uint256) public balances;
    mapping(address => uint256[]) public payments;

    function receivePayment(uint256 _payment) payable external {
        balances[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] += 10;
        require(balances[msg.sender] >= _payment);

        balances[msg.sender] -= _payment;
        payments[msg.sender].push(_payment);
    }

    function checkBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function refundPayment(uint256 _transaction) payable public virtual {

    }
}

contract Merchant is PaymentProcessor {
    function refundPayment(uint256 _transaction) payable public override {
        // remove payment from array
        balances[msg.sender] += payments[msg.sender][_transaction];
        payments[msg.sender][_transaction] = payments[msg.sender][payments[msg.sender].length - 1];
        payments[msg.sender].pop();
    }
}