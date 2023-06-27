const tetherContract = artifacts.require("Tether");
const dummyContract = artifacts.require("DummyToken");
const stakingDappContract = artifacts.require("StakingDapp");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(tetherContract);
  const tetherToken = await tetherContract.deployed();

  await deployer.deploy(dummyContract);
  const dummyToken = await dummyContract.deployed();

  await deployer.deploy(
    stakingDappContract,
    dummyToken.address,
    tetherToken.address
  );
  const stakingDappToken = await stakingDappContract.deployed();

  await dummyContract.transfer(stakingDappToken.address, "1000000000000000000");
  await tetherToken.transfer(accounts[1], "1000000000000000000");
};
