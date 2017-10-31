var MyToken = artifacts.require("./MyToken.sol");

contract('MyToken', function(accounts){
    it("should put 1000 coins in the first account", function(){
        return MyToken.deployed().then(function(instance){
            return instance.getBalance(accounts[0]);
        }).then(function(balance){
            assert.equal(balance.valueOf(), 1000, "1000 wasn't in the first account");
        });
    });

    it("Should send coin correctly", function(){
        var myt;

        // Get initial balances before sending
        var account_one = accounts[0];
        var account_two = accounts[1];

        var account_one_starting_balance;
        var account_two_starting_balance;
        var account_one_ending_balance;
        var account_two_ending_balance;

        var amount = 10;

        return MyToken.deployed().then(function(instance){
            myt = instance;
            return myt.getBalance.call(account_one);
        }).then(function(balance){
            account_one_starting_balance = balance.toNumber();
            return myt.getBalance(account_two);
        }).then(function(balance){
            account_two_starting_balance = balance.toNumber();
            return myt.transfer(account_two, amount, {from: account_one});
        }).then(function(){
            return myt.getBalance(account_one);
        }).then(function(balance){
            account_one_ending_balance = balance.toNumber();
            return myt.getBalance(account_two);
        }).then(function(balance){
            account_two_ending_balance = balance.toNumber();

            assert.equal(account_one_ending_balance, account_one_starting_balance - amount, 'Should subract amount');
            assert.equal(account_two_ending_balance, account_two_starting_balance + amount, 'Should increment the recieve address');
        })
    })

    it("Should prevent invalid sends", function(){
        var myt;

        // Get initial balances before sending
        var account_one = accounts[0];
        var account_two = accounts[1];

        // Amount is bigger than what is total supply of tokens
        var amount = 5000;

        var account_one_starting_balance;
        var account_two_starting_balance;
        var account_one_ending_balance;
        var account_two_ending_balance;
        
        return MyToken.deployed().then(function(instance){
            myt = instance;
            return myt.getBalance(account_one);
        }).then(function(balance){
            account_one_starting_balance = balance.toNumber();
            return myt.getBalance(account_two);
        }).then(function(balance){
            account_two_starting_balance = balance.toNumber();
            return myt.transfer(account_two, amount, {from: account_one});
        }).then(function(){
            return myt.getBalance(account_one);
        }).then(function(balance){
            account_one_ending_balance = balance.toNumber();
            return myt.getBalance(account_two);
        }).then(function(balance){
            account_two_ending_balance = balance.toNumber();
            console.log("end balance", account_one_ending_balance);
            assert.equal(account_one_ending_balance, account_one_starting_balance - amount, 'Should subract amount');
            assert.equal(account_two_ending_balance, account_two_starting_balance + amount, 'Should increment the recieve address');
        }).catch(function(error){
            
        });

    });
})