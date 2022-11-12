const hre = require("hardhat");

async function main() {
  const TicketEx = await hre.ethers.getContractFactory("TicketEx");
  const EventFactory = await hre.ethers.getContractFactory("EventFactory");
  const ticketex = await TicketEx.deploy();
  console.log("deploying ticketex");
  await ticketex.deployTransaction.wait(6);
  await hre.run("verify:verify", {
    address: ticketex.address,
    constructorArguments: [],
  });
  const eventfactory = await EventFactory.deploy(`${ticketex.address}`);
  console.log("deploying factory");
  await eventfactory.deployTransaction.wait(6);
  await hre.run("verify:verify", {
    address: eventfactory.address,
    constructorArguments: [`${ticketex.address}`],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
