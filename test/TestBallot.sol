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
}
