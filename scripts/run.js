const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  // compiles the contract and generates ABI files under the artifacts directory

  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  /* says, "go and deploy my contract and fund it with 0.1 ETH" */
  });
  // creating a local Ethereum network for this contract
  await waveContract.deployed();
  console.log("Contract deployed to:", waveContract.address);
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
    So that when we call wave(), 0.0001 ETH is removed from the contract */
    );


   // doing wave 1
  const waveTxn = await waveContract.wave("This is wave #1");
  await waveTxn.wait(); // waiting for transaction to be mined
  waveTxn.wait();

  const [_, randomPerson] = await hre.ethers.getSigners();

  // doing wave 2
  const waveTxn2 = await waveContract.connect(randomPerson).wave("This is wave #2");
  await waveTxn2.wait(); // waiting for 2nd transaction to be mined
  waveTxn2.wait();



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




