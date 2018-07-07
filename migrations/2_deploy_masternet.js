var MasterNet = artifacts.require("./Masternet.sol");

module.exports = function(deployer, network, accounts) {
  let account = accounts[0];
  console.log("Network: ", network)
  console.log("Account deploy: ", account);
  
  deployer.deploy(MasterNet, {from: account});
};