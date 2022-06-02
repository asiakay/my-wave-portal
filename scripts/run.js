const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal"); // compiles the contract and generates files under the artifacts directory 
    const waveContract = await waveContractFactory.deploy(); // getting hardhat to create a local Ethereum network for this contract that will self destruct after the script completes 
    await waveContract.deployed(); // waiting until the contrct is deployed to the local blockchain
    console.log("Contract deployed to:", waveContract.address); // once deployed, "waveContract.address" will give the address of the deployed contract
};

const runMain = async () => {
    try {
        await main();
        process.exit(0); // exit Node process without error
    } catch (error){
        console.log(error);
        process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
    }
    // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
};

runMain();