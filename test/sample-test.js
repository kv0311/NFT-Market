const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("test", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Draw = await ethers.getContractFactory("Draw");
    const draw = await Draw.deploy();
    await draw.deployed();

    expect(await draw.createRect()).to.equal(`<rect width="140" height="10" x="90" y="210" fill="#eed811" />`);

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
