pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Ballot.sol";

contract TestBallot{
  Ballot ballot = Ballot(DeployedAddresses.Ballot());

  function testChairpersonAssignedToBallotUponProposal() public {
    ballot.Register("Taxing Northwestern");

    address expected = this;
    address actual = ballot.getChairperson();

    Assert.equal(actual, expected, "Chairperson of ballot should be recorded");
  }

  function testProposalIsAddedToListOfPropsoals() public {
    ballot.Register("Tax Northwestern");

    //
    //NO way to make these tests automic such that I don't account for the test above incrementing the proposal count
    //
    uint expected = 2;
    uint actual = ballot.getProposalCount();

    Assert.equal(actual, expected, "Proposal should have been recorded.");
  }
}
