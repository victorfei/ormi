// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
import { ContractFactory } from "ethers";
import { LendingPool} from "../typechain";

const contractNames = {
  DataTypes: "DataTypes",
  LendingPool: "LendingPool",
  ReserveLogic: "ReserveLogic",
} as const;

export const deployCore = async () => {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // DataTypes contract deployment
  // const DataTypesFactory: ContractFactory = await ethers.getContractFactory(
  //   contractNames.DataTypes
  // );
  // const dataTypesContract: DataTypes =
  //   (await DataTypesFactory.deploy()) as DataTypes;
  // await DataTypes.deployed();
  // console.log(
  //   `${contractNames.DataTypes} deployed to: ${dataTypesContract.address}`
  // );

  // ReserveLogic contract deployment
  // const ReserveLogicFactory: ContractFactory = await ethers.getContractFactory(
  //   contractNames.ReserveLogic
  // );
  // const reserveLogicContract: ReserveLogic =
  //   (await ReserveLogicFactory.deploy()) as ReserveLogic;
  // await ReserveLogic.deployed();
  // console.log(
  //   `${contractNames.ReserveLogic} deployed to: ${reserveLogicContract.address}`
  // );

  // LendingPool contract deployment
  const LendingPoolFactory: ContractFactory = await ethers.getContractFactory(
    contractNames.LendingPool
  );
  const lendingPoolContract: LendingPool =
    (await LendingPoolFactory.deploy()) as LendingPool;
  await lendingPoolContract.deployed();
  console.log(
    `${contractNames.LendingPool} deployed to: ${lendingPoolContract.address}`
  );


  // const LendingPoolFactory: ContractFactory = await ethers.getContractFactory(
  //   contractNames.LendingPool
  // );
  return { lendingPoolContract };
};

async function main() {
  // We get the contract to deploy
  const Greeter = await ethers.getContractFactory("Greeter");
  const greeter = await Greeter.deploy("Hello, Hardhat!");

  await greeter.deployed();

  console.log("Greeter deployed to:", greeter.address);

  const {lendingPoolContract } = await deployCore();
  console.log("Complete deployment");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
