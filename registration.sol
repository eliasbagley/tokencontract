contract Token {
  address creator;
  mapping(uint => address) private tokenMap;
  mapping(uint => bool) private registered;
  mapping(address => uint) private addressMap;
  uint private tokenNonce = 0xcafebabe;

  function Token() {
    creator = msg.sender;
  }

  function createRegistrationToken() returns (uint) {
      uint token = generateRandomToken();
      registered[token] = false;
  }

  function register(uint token) returns (bool) {
      if (registered[token] == false) {
        tokenMap[token] = msg.sender;
        addressMap[msg.sender] = token;
        registered[token] = true;
        return true;
      }

      return false;
  }

  event Login(uint token);

  function login() {
    Login(addressMap[msg.sender]);
  }





  function authenticate(uint token) returns (bool) {
      bool authenticated = tokenMap[token] == msg.sender;
      tokenMap[token] = 0;
      return authenticated;
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

