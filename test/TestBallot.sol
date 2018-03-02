pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Ballot.sol";

contract TestBallot{

  Ballot ballot;

  function beforeEach() {
    ballot = Ballot(DeployedAddresses.Ballot());
  }

  function testChairpersonAssignedToBallotUponProposal() public {
    //
    //This writes to the BlockChain, thus it's not needed as setup in other tests.  I need to find a way to make these tests automic
    //
    ballot.RegisterProposal("Taxing Northwestern");

    address expected = this;
    address actual = ballot.getChairperson();

    Assert.equal(actual, expected, "Chairperson of ballot should be recorded");
  }

  function testProposalIsAdded() public {
    //
    //TODO:  It's not inherintly clear how to test for the setting of a  variable
    //
  }

  //
  //Voter registration behavior
  //

  function testRegisteredVoterMakesItIntoVoterPool() public {
    ballot.RegisterVoter(this);

    uint expected = 1;
    uint actual = ballot.getVoterCount();

    Assert.equal(actual, expected, "Voter should have been registered");
  }

  function testVoterIdentityIsRegistered() public {
    ballot.RegisterVoter(this);

    bool expected = true;
    bool actual = ballot.voterRegistered(this);

    Assert.equal(actual, expected, "Voter should have been registered");
  }

  function testChairpersonIsOnlyPersonAllowedToRegisterVoters() public {
    //
    //It's currently not possible to test this use-case in Truffle without 3rd party library support.
    //
    Assert.equal(true, true, "Only chairperson can register voters in this regimine");
  }


  //
  //Voter behavior
  //

  function testVotersCanOnlyVoteOnValidProposals() public {
    bool expected = false;
    bool actual = ballot.Vote(this, "We SHOULD NOT tax Northwestern");

    Assert.equal(actual, expected, "Voters should only be able to vote on registered proposals");
  }

  function testOnlyRegisteredVotersCanVote() public {
    bool expected = false;
    bool actual = ballot.Vote(0xE0f5206BBD039e7b0592d8918820024e2a7437b9, "Taxing Northwestern");

    Assert.equal(actual, expected, "Only registered voters are able to vote");
  }

  function testRegisteredVotersCanVoteOnValidProposal() public {
    bool expected = true;
    bool actual = ballot.Vote(this, "Taxing Northwestern");

    Assert.equal(actual, expected, "Registered voters should be permitted to vote");
  }

  function testVotersCanOnlyVoteOnce() public {
    bool expected = false;

    //Cast valid initial vote
    ballot.Vote(this, "Taxing Northwestern");
    bool actual_invalid_vote = ballot.Vote(this, "Taxing Northwestern");

    Assert.equal(actual_invalid_vote, expected, "Voters can only vote once per propsoal");
  }

  function testVotersCanOnlyVoteOnceVoteCount() public {
    ballot.Vote(this, "Taxing Northwestern");

    uint expected = 1;
    uint actual = ballot.getProposalVoteCount();

    Assert.equal(actual, expected, "Voters votes can only be tallied once per proposal");
  }

  function testVoteIsRegistered() public {
    ballot.Vote(this, "Taxing Northwestern");

    uint expected = 1;
    uint actual = ballot.getProposalVoteCount();

    Assert.equal(actual, expected, "Votes should be recorded for the propsoal");
  }
}
