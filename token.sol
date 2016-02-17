contract Token {
  address creator;
  mapping(uint => address) private tokenMap;

  function Token() {
    creator = msg.sender;
  }

  function createToken() {
    uint token = generateRandomToken();
    tokenMap[token] = msg.sender
  }

  function redeem(uint token) returns (address) {
    address ad = tokenMap[token]
    tokenMap[token] = 0;
    return ad;
  }

  // Private helper methods

  //TODO make this return a random token instead of the current time...
  function generateRandomToken() private returns (uint){
    return sha3_256(now);
  }


  // Allows this contract to be shut down and the funds recovered
  function kill() {
    if (msg.sender == creator) {
      suicide(creator);
    }
  }

}
