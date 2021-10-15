import { expect } from "chai";
import { ethers } from "hardhat";

const TEST_ERC_20_ADDR: string = "0x26D5Bd2dfEDa983ECD6c39899e69DAE6431Dffbb";
describe("Deposit", function () {
  it("User deposits asset, should see balance increase", async function () {
    const LendingPool = await ethers.getContractFactory("LendingPool");
    const lendingPool = await LendingPool.deploy();
    await lendingPool.deployed();

    let accounts = await ethers.getSigners();
    const depositTx = await lendingPool.deposit(
      TEST_ERC_20_ADDR,
      101,
      accounts[1].address
    );

    await depositTx.wait();
    console.log(
      "Reserve amount:",
      await lendingPool.getAssetReserveAmount(TEST_ERC_20_ADDR)
    );
    expect(await lendingPool.getAssetReserveAmount(TEST_ERC_20_ADDR)).to.equal(
      101
    );
  });
});
