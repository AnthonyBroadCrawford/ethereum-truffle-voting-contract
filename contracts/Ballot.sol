pragma solidity ^0.4.16;

contract Ballot {

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
  //
  address public chairperson;

  Voter[] public voters;
  Proposal public proposal;

  function RegisterProposal(string proposalName) public {
    chairperson = msg.sender;
    proposal = Proposal({
      name: proposalName,
      voteCount: 0
    });
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

  function Vote(address voterIdentity, string proposalName) public view returns (bool) {
    bool successfullyVoted = true;

    if(keccak256(proposal.name) != keccak256(proposalName)){
      return false;
    }

    if(voterRegistered(voterIdentity) == false){
      return false;
    }

    Voter storage voter;

    //
    //I have a private function below, but I don't know enough why returning this variable from a private function causing a cast error (not grocking something fundamental about the Blockchain)
    //
    for(uint index = 0; index < voters.length; index++){
      if(voters[index].delegate == voterIdentity){
        voter = voters[index];
      }
    }

    if(voter.voted == true){
      return false;
    }

    voter.voted = true;
    successfullyVoted = true;

    //voter.vote = NEEDS PASSED IN
    proposal.voteCount++;


    return successfullyVoted;
  }


  //
  //Private support functions
  //
  function getVoterByIdentity(address voterIdentity) private view returns (Voter){
    require(voterRegistered(voterIdentity) == true);

    Voter storage voter;

    for(uint index = 0; index < voters.length; index++){
      if(voters[index].delegate == voterIdentity){
        voter = voters[index];
      }
    }

    return voter;
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

  function getProposalVoteCount() public view returns (uint) {
    return proposal.voteCount;
  }

  function getChairperson() public view returns (address){
    return chairperson;
  }
}
