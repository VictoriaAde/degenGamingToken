import { ethers } from "hardhat";

async function main() {
  // const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  // const unlockTime = currentTimestampInSeconds + 60;

  const initialSupply = 1000;

  const degen = await ethers.deployContract(
    "DegenGamingToken",
    [initialSupply],
    {}
  );

  await degen.waitForDeployment();

  console.log(`DegenGamingToken deployed to ${degen.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
