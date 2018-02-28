pragma solidity ^0.4.16;

contract Ballot {

  //
  //declare our data types
  //
  struct Voter {
    uint weight;
    bool voted;
    address delegate;
    uint vote;
  }

  struct Proposal {
    string name;
    uint voteCount;
  }

  //
  //declare Contract variables
  address public chairperson;

  mapping(address => Voter) public voters;

  Proposal[] public proposals;

  function Register(string proposalName) public {
    chairperson = msg.sender;
  }

  function getChairperson() public view returns (address){
    return chairperson;
  }
}
