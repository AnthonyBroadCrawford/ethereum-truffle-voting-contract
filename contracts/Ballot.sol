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
    proposals.push(Proposal({
        name: proposalName,
        voteCount: 0
      }));
  }

  //
  //Getters for access (currently accessed only in the unit test suite)
  //
  function getProposalCount() public view returns (uint) {
    return proposals.length;
  }

  function getChairperson() public view returns (address){
    return chairperson;
  }
}
