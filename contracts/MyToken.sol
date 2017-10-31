pragma solidity ^0.4.11;

/* This token contract borrows heavily form the example on
  https://ethereum.org/token   I will create unit test for every
  function in the contract

  */

/* Minimum viable token */
contract MyToken {
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;

    /* Inititalizes contract with initital supply tokens to 
      the creator of the contract */
    uint public initialSupply;
    address public originAddress;

    function MyToken(uint supply) public {
        initialSupply = supply;
        originAddress = msg.sender;
        balanceOf[msg.sender] = initialSupply;
    }

    /* Send Coins */
    function _transfer(address _from, address _to, uint _value) internal {
        require(balanceOf[_from] >= _value);  // Check if sender has enough
        require(balanceOf[_to] + _value >= balanceOf[_to]); // Checks for overflows
        balanceOf[_from] -= _value; // subtract from sender
        balanceOf[_to] += _value; // add to recipient
    }

    function transfer(address _to, uint256 _value) public {
      _transfer(msg.sender, _to, _value);
    }

    // Check balance
    function getBalance(address addr) constant returns(uint) {
		  return balanceOf[addr];
	  }
}