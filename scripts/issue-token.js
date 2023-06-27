const StakingDapp = artifacts.require("StakingDapp");

module.exports = async function (callback) {
  let stakingdapp = await StakingDapp.deployed();
  await stakingdapp.issueDummyToken();

  console.log("dummy tokens issued!");
  callback();
};
