contract Token {
  address creator;
  mapping(uint => address) private tokenMap;
  uint private tokenNonce = 0xcafebabe;

  function Token() {
    creator = msg.sender;
  }

  function createToken() returns (uint) {
    uint token = generateRandomToken();
    tokenMap[token] = msg.sender;
    return token;
  }

  function redeem(uint token) returns (address) {
    address ad = tokenMap[token];
    tokenMap[token] = 0;
    return ad;
  }

  // Private helper methods

  //TODO true randomness is still an unsolved problem
  function generateRandomToken() private returns (uint) {
    tokenNonce++;
    uint lastBlockHash = uint(block.blockhash(block.number - 1));
    return uint(sha3(now + tokenNonce + block.timestamp + lastBlockHash));
  }

  // Allows this contract to be shut down and the funds recovered
  function kill() {
    if (msg.sender == creator) {
      suicide(creator);
    }
  }

}

