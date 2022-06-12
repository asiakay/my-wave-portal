const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    // compiles the contract and generates ABI files under the artifacts directory
    const waveContract = await waveContractFactory.deploy({
      value: hre.ethers.utils.parseEther("0.1"),
      /* says, "go and deploy my contract and fund it with 0.1 ETH" */
    });
    // creating a local Ethereum network for this contract
    await waveContract.deployed();
    console.log('Contract deployed to:', waveContract.address);
    // the address contract is deployed to
    // console.log("Contract deplyoyed by:", owner.address);
    // the address of the person deploying our contract

    // Getting Contract balance 
    let contractBalance = await hre.ethers.provider.getBalance(
      waveContract.address
    );
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );

    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());
    // call the function to grab the # of total waves

    let waveTxn = await waveContract.wave("A message");
    // doing the wave
    await waveTxn.wait(); // waiting for transaction to be mined

    const [_, randomPerson] = await hre.ethers.getSigners();
    waveTxn = await waveContract.connect(randomPerson).wave("Another Message");
    await waveTxn.wait(); // Wait for the second transaction to be mined


    /* Get contract balance to see what happened */
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
      /* testing to see if the contract has a balance of 0.1. 
      and that when we call wave(), 0.0001 ETH is removed from the contract */
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