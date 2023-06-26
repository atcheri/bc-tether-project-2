// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Tether {
    string public name = "Dummy Tether";
    string public symbol = "Tether";
    uint totalSupply = 100000000000000000;
    uint decimal = 18;

    event Transfered(address indexed _from, address indexed _to, uint _value);
    event Approved(
        address indexed _owner,
        address indexed _spender,
        uint _value
    );

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    constructor() public {
        balances[msg.sender] = totalSupply;
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balances[msg.sender] >= _value, "not enough funds to transfer");

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfered(msg.sender, _to, _value);

        return true;
    }
}
