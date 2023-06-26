// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./DummyToken.sol";
import "./Tether.sol";

contract StakingDapp {
    string public name = "Staking DApp";
    address public owner;
    DummyToken public dummyToken;
    Tether public tetherToken;

    address[] public stakers;
    mapping(address => uint) public stakingBalances;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DummyToken _dummyToken, Tether _tetherToken) public {
        owner = msg.sender;
        dummyToken = _dummyToken;
        tetherToken = _tetherToken;
    }

    function stakeToken(uint _amount) public {
        require(_amount > 0, "amount canno be zero");

        tetherToken.transferFrom(msg.sender, address(this), _amount);

        stakingBalances[msg.sender] += _amount;

        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        hasStaked[msg.sender] = true;
        isStaking[msg.sender] = true;
    }

    function unstakeToken() public {
        uint balance = stakingBalances[msg.sender];

        require(balance > 0, "staking balance must be greater than zero");

        tetherToken.transfer(msg.sender, balance);
        stakingBalances[msg.sender] = 0;
        isStaking[msg.sender] = false;
    }

    function issueDummyToken() public {
        require(
            msg.sender == owner,
            "caller must be the owner for this function"
        );

        for (uint i = 0; i > stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = stakingBalances[recipient];

            if (balance > 0) {
                dummyToken.transfer(recipient, balance);
            }
        }
    }
}
