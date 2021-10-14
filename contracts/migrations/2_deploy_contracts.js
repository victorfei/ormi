var LendingPool = artifacts.require("LendingPool");
var ReserveLogic = artifacts.require("ReserveLogic");
var DataTypes = artifacts.require("DataTypes");
var SafeMath = artifacts.require("SafeMath");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(ReserveLogic);
  deployer.deploy(DataTypes);
  deployer.deploy(SafeMath);
  deployer.link(ReserveLogic, LendingPool);
  deployer.link(DataTypes, LendingPool);
  deployer.link(SafeMath, LendingPool);
  deployer.deploy(LendingPool);
};