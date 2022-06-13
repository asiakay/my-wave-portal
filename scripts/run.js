const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  // compiles the contract and generates ABI files under the artifacts directory

  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  /* says, "go and deploy my contract and fund it with 0.1 ETH" */
  });
  // creating a local Ethereum network for this contract

  await waveContract.deployed();
  console.log("Contract addy:", waveContract.address);
  // the address contract is deployed to
  // console.log("Contract deplyoyed by:", owner.address);
  // the address of the person deploying our contract

  let contractBalance = await hre.ethers.provider.getBalance(
  // Getting Contract balance 
  waveContract.address
  );
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  /* testing to see if the contract has a balance of 0.1. 
  and that when we call wave(), 0.0001 ETH is removed from the contract */
  );

  /*
   * Let's try two waves now
   */
  const waveTxn = await waveContract.wave("This is wave #1");
  // doing wave 1
  await waveTxn.wait();

  const waveTxn2 = await waveContract.wave("This is wave #2");
  // doing wave 2
  await waveTxn2.wait();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();




