// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

contract AssetFactory {
    mapping(address => string) private assetsAddresses;
    Asset[] private assets;

    function createAsset(string memory _symbol, string memory _name, uint256 _supply, address _address) public {
        Asset newAsset = new Asset(_symbol, _name, _supply);

        assets.push(newAsset);
        assetsAddresses[_address] = _symbol;
    }
}

contract Asset {
    string symbol;
    string name;
    uint256 supply;

    constructor(string memory _symbol, string memory _name, uint256 _supply) public {
        symbol = _symbol;
        name = _name;
        supply = _supply;
    }
}