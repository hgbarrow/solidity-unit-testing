pragma solidity ^0.4.15;

/*Erc20 compatible token contract. This contract borrows heavily from 
  https://ethereum.org/token I will create unit test for every function

*/

contract MyTokenERC20 {
    // Public variables of the token
    string public name;
    string public symbol;
    uint8 public decimals = 18; // 18 is the standard amount
    
    uint256 public totalSupply;

    // Create an array with all balances
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping (address => uint256)) public allowance;

    // This generates a public event on the blockchain that will notify clients
    event Transfer(address indexed from, address indexed to, uint value);

    // This notifies clients about the amount burnt
    event Burn(address indexed from, uint256 value);

    // Constructor function
    function MyTokenERC20(
        uint256 initialSupply,
        string tokenName,
        string tokenSymbol
    ) public {
        totalSupply = initialSupply * 10 ** uint(decimals);
        balanceOf[msg.sender] = totalSupply; // Give the creator all initial tokens
        name = tokenName; // set the name and symbol for display purposes
        symbol = tokenSymbol;
    }

    // Internal Transfer function
    function _transfer(address _from, address _to, uint _value) internal {
        // Prevent transfer to 0x0 address. Use burn instead
        require(_to != 0x0);
        // Check if sender has enough
        require(balanceOf[_from] >= _value);
        // Check for overflows
        require(balanceOf[_to] + _value > balanceOf[_to]);
        // Save this for an assertion in the future
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        // Subtract from sender
        balanceOf[_from] -= _value;
        // Add the same to the reipient
        balanceOf[_to] += _value;
        Transfer(_from, _to, _value);
        // Asserts are used to use static analysis to find bugs in your code. They should never fail
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

    /* Transfer Tokens
     * @param _to The address of the recipient
     * @param _value the amount to send

     */
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }


}