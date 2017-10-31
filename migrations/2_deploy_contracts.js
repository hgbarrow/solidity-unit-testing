var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var MyToken = artifacts.require("./MyToken.sol");
var MyTokenERC20 = artifacts.require("./MyTokenERC20.sol")

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(MyToken, 1000);
  deployer.deploy(MyTokenERC20, 1000000, "GalleyCoin", "GalleyCoin");
};
