const BigNumber = require('bignumber.js')
const BlankToken = artifacts.require('./BLANKPTOY.sol')

const raceTo18 = value =>
  new BigNumber(value * 10 ** 18)
    .toFixed()
    .toString()
    .toString()

module.exports = async (deployer, network, [owner]) => {
  // await deployer.deploy(PToyToken, "BlankToken", "DPTOY", 18, 210000000);
  const initialSupply = raceTo18(5000000000)
  const supplyCap = raceTo18(10000000000)
  await deployer.deploy(BlankToken, supplyCap, initialSupply)

  console.log(`
    ==========================================================================================
       Deployed Contracts:

       BlankToken Address: ${BlankToken.address}
    ==========================================================================================
  `)

  const Token = await BlankToken.deployed()

  // console.log(Token)

  await Token.transfer(
    '0x9455fd3323637368F14939f8330C400cA467869B',
    raceTo18(100000),
    {
      from: owner
    }
  )

  await Token.transfer(
    '0xF33b59C11D5c9f726DC5bCBC2d6D3705046ED78a',
    raceTo18(100000),
    {
      from: owner
    }
  )

  await Token.transfer(
    '0x80Eeb004D076885b39bF94557B1477096bf8f105',
    raceTo18(100000),
    {
      from: owner
    }
  )

  await Token.transfer(
    '0xdD20B040c75036b4fD919024356aBccafDAD0bd0',
    raceTo18(100000),
    {
      from: owner
    }
  )

  await Token.transfer(
    '0xCB88F020EeC5651B71C759734624471c12eA5902',
    raceTo18(100000),
    {
      from: owner
    }
  )

  await Token.transfer(
    '0xf35A3D28B488a6438959b043E8Ac044C8c3e6456',
    raceTo18(1000000),
    {
      from: owner
    }
  )

  await Token.transfer(
    '0xF41Bc48f182541045ACe0d51aa8e75c102468F74',
    raceTo18(1000000),
    {
      from: owner
    }
  )

  // await Token.transfer("0xF33b59C11D5c9f726DC5bCBC2d6D3705046ED78a", 20000 * (10 ** 18), { from: owner });
  // await Token.transfer("0x80Eeb004D076885b39bF94557B1477096bf8f105", 20000 * (10 ** 18), { from: owner });
  // await Token.transfer("0xdD20B040c75036b4fD919024356aBccafDAD0bd0", 20000 * (10 ** 18), { from: owner });
  // await Token.transfer("0xCB88F020EeC5651B71C759734624471c12eA5902", 20000 * (10 ** 18), { from: owner });
  // await Token.transfer("0xf35A3D28B488a6438959b043E8Ac044C8c3e6456", 20000 * (10 ** 18), { from: owner });
  // await Token.transfer("0xF41Bc48f182541045ACe0d51aa8e75c102468F74", 20000 * (10 ** 18), { from: owner });
}
