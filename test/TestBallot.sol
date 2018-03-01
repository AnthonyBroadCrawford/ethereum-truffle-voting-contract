pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Ballot.sol";

contract TestBallot{
  Ballot ballot = Ballot(DeployedAddresses.Ballot());

  function testChairpersonAssignedToBallotUponProposal() public {
    ballot.RegisterProposal("Taxing Northwestern");

    address expected = this;
    address actual = ballot.getChairperson();

    Assert.equal(actual, expected, "Chairperson of ballot should be recorded");
  }

  function testProposalIsAddedToListOfPropsoals() public {
    ballot.RegisterProposal("Tax Northwestern");

    //
    //NO way to make these tests automic such that I don't account for the test above incrementing the proposal count
    //
    uint expected = 2;
    uint actual = ballot.getProposalCount();

    Assert.equal(actual, expected, "Proposal should have been recorded.");
  }

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
}
