const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log("Deploying contracts with account: ", deployer.address);
  console.log("Account balance: ", accountBalance.toString());

  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    /* funding the contract 0.001 ETH */
    value: hre.ethers.utils.parseEther("0.001"),
  });
  await waveContract.deployed();
  /* made it easier to know when it's deployed */

  console.log("WavePortal address: ", waveContract.address);
};

  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
  };
  
  runMain();