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

  Voter[] public voters;
  Proposal[] public proposals;

  function RegisterProposal(string proposalName) public {
    chairperson = msg.sender;
    proposals.push(Proposal({
        name: proposalName,
        voteCount: 0
      }));
  }

  function RegisterVoter(address voter) public {
    //ensure only the Chairperson can register a Voter
    require(msg.sender == chairperson);

    //future refactor to check that the person isn't already registered.
    voters.push(Voter({
        weight: 0,
        voted: false,
        delegate: voter,
        vote: 0
      }));
  }

  //
  //Getters for access (currently accessed only in the unit test suite)
  //
  function voterRegistered(address voter) public view returns (bool) {
    bool registered = false;

    for(uint index = 0; index < voters.length; index++){
      if(voters[index].delegate == voter){
        registered = true;
      }
    }

    return registered;
  }

  function getVoterCount() public view returns (uint){
    return voters.length;
  }

  function getProposalCount() public view returns (uint) {
    return proposals.length;
  }

  function getChairperson() public view returns (address){
    return chairperson;
  }
}
