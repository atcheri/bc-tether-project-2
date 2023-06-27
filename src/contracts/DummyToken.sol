// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DummyToken {
    string public name = "Dummy Token";
    string public symbol = "DumToken";
    uint totalSupply = 1000000000000000000000000;
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

    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        allowances[msg.sender][_spender] = _value;

        emit Approved(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balances[_from] >= _value, "not enough fund to transfer");
        require(
            allowances[_from][msg.sender] >= _value,
            "not allowed to transfer more than the what remains"
        );

        balances[_from] -= _value;
        balances[_to] += _value;
        allowances[_from][msg.sender] -= _value;

        emit Transfered(_from, _to, _value);

        return true;
    }
}
