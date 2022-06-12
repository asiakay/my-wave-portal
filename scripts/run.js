const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    // compiles the contract and generates ABI files under the artifacts directory
    const waveContract = await waveContractFactory.deploy();
    // creating a local Ethereum network for this contract
    await waveContract.deployed();
    console.log('Contract deployed to:', waveContract.address);
    // the address contract is deployed to
    // console.log("Contract deplyoyed by:", owner.address);
    // the address of the person deploying our contract

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