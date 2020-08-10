const BigNumber = require('bignumber.js')
const BlankToken = artifacts.require('./BLANKPTOY.sol')

const toWeiDecimal = value =>
  new BigNumber(value * 10 ** 8).toFixed().toString()

const transfer = (token, owner, amount) => async account => {
  await token.transfer(account, toWeiDecimal(amount), {
    from: owner
  })
}

module.exports = async (deployer, network, [owner]) => {
  const initialSupply = toWeiDecimal(5000000000)
  const supplyCap = toWeiDecimal(10000000000)
  await deployer.deploy(BlankToken, supplyCap, initialSupply)

  console.log(`
    ===========================================
    Deployed Contracts:
    BlankToken Address: ${BlankToken.address}
    ===========================================
  `)

  const Token = await BlankToken.deployed()
  const transfer100K = transfer(Token, owner, 100000)
  const transfer1ML = transfer(Token, owner, 1000000)

  await transfer100K('0x9455fd3323637368F14939f8330C400cA467869B')
  await transfer100K('0xF33b59C11D5c9f726DC5bCBC2d6D3705046ED78a')
  await transfer100K('0x80Eeb004D076885b39bF94557B1477096bf8f105')
  await transfer100K('0xdD20B040c75036b4fD919024356aBccafDAD0bd0')
  await transfer100K('0xCB88F020EeC5651B71C759734624471c12eA5902')
  await transfer1ML('0xf35A3D28B488a6438959b043E8Ac044C8c3e6456')
  await transfer1ML('0xF41Bc48f182541045ACe0d51aa8e75c102468F74')
}
