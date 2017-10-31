pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MyToken.sol";

contract TestMyToken {
    MyToken myt = MyToken(DeployedAddresses.MyToken());
    function testInitialBalance() {
        
        uint expected = 1000;

        Assert.equal(myt.getBalance(tx.origin), expected, "Owner should have all coins inititally");
        Assert.equal(myt.originAddress(), tx.origin, "Origin should be address 1");
    }

    function testInitialSupplySet() {
        uint expected = 1000;

        Assert.equal(myt.initialSupply(), expected, "InitialSupply variable should be set and publically accessable");
    }

    // function testSimpleTransfer() {
    //     // Test if sending tokens is working under normal conditions
    //     address to = 0xbbc95535ca8a805078920f7aee103d54106fcc26;

    //     uint amount = 125;


    //     myt.transfer(to, amount);
    //     Assert.equal(myt.getBalance(to), amount, "Recipient should receive tokens");
    // }
}

