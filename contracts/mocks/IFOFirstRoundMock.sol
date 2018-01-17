pragma solidity ^0.4.18;


import '../IFOFirstRound.sol';

contract IFOFirstRoundMock is IFOFirstRound {

  function pauseToken() public onlyOwner {
    return token.pause();
  }

  function acceptingRequests() public constant returns (bool) {
    return (currentState() == "PreDist");
  }

  function getCurrentState() public constant returns (string) {
    return bytes32ToString(currentState());
  }

  function bytes32ToString(bytes32 x) public constant returns (string) {
    bytes memory bytesString = new bytes(32);
    uint charCount = 0;
    for (uint j = 0; j < 32; j++) {
      byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
      if (char != 0) {
        bytesString[charCount] = char;
        charCount++;
      }
    }
    bytes memory bytesStringTrimmed = new bytes(charCount);
    for (j = 0; j < charCount; j++) {
      bytesStringTrimmed[j] = bytesString[j];
    }
    return string(bytesStringTrimmed);
  }

  function startPreDistribution(uint _startBlock, uint _duration, address _project, address _founders) public onlyOwner onlyState("Inactive") {
    require(_startBlock > block.number);
    require(_duration > 10 && _duration < 100);
    require(msg.sender != address(0));
    require(_project != address(0));
    require(_founders != address(0));

    project = _project;
    founders = _founders;
    preDuration = _duration;
    preStartBlock = _startBlock;
    preEndBlock = _startBlock + _duration;
  }

}
