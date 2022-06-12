const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.001"),
    /* funded the contract 0.001 ETH */
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