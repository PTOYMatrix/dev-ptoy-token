# Setup Ganache CLI and deploy local token

- Clone the repo
- Install make `sudo apt install make`
- Install docker `sudo make install-docker-if-not-already-installed`
- Install node `sudo make install-node`
- Run `yarn install` to install the dependencies
- Setup Ganache CLI:
- Ganache CLI using docker

```bash
sudo make install-ganache
```

<div style="text-align: center">OR</div>

```bash
docker run -d -p 8545:8545 --name ganache trufflesuite/ganache-cli:latest -d -a 50 -m "man swing emotion lucky riot together behind connect swim allow protect winter" --host 0.0.0.0 --debug
```

<div style="text-align: center">OR</div>

- Ganache CLI using Node

```bash
npm i -g ganache-cli
ganache-cli -d -a 50 -m "man swing emotion lucky riot together behind connect swim allow protect winter" --host 0.0.0.0
```

- Run `sudo make migrate-contract` to compile and deploy the contracts

<div style="text-align: center">OR</div>

- update ganache `host` in `truffle.js` under `development` network
- Compile token contract `./node_modules/.bin/truffle compile --network development`
- Migrate token contract `./node_modules/.bin/truffle migrate --network development`
- Migration will populate following accounts with tokens

```bash
# Wallets
- 0x9455fd3323637368F14939f8330C400cA467869B - (500 ETH) - (100000 DPTOY)
- 0xF33b59C11D5c9f726DC5bCBC2d6D3705046ED78a - (500 ETH) - (100000 DPTOY)
- 0x80Eeb004D076885b39bF94557B1477096bf8f105 - (500 ETH) - (100000 DPTOY)
- 0xdD20B040c75036b4fD919024356aBccafDAD0bd0 - (500 ETH) - (100000 DPTOY)
- 0xCB88F020EeC5651B71C759734624471c12eA5902 - (500 ETH) - (100000 DPTOY)
- 0xf35A3D28B488a6438959b043E8Ac044C8c3e6456 - (500 ETH) - (1000000 DPTOY)
- 0xF41Bc48f182541045ACe0d51aa8e75c102468F74 - (500 ETH) - (1000000 DPTOY)

# Private Keys
- 0x7b1dc2bdec0d1f2779804a2883ab70870571504e8ed1142063b22125081a21ce
- 0x631a3a90cc826c671d29f3086d073572314cf8301e0a7d9779641eedeb948e36
- 0xc721fe5ef23fda490ac472c92daedb07bbbdf6609fb817d4bf87fb6e65d434d0
- 0xf4d0abb8250b174fcf0f779af6086056f72996530dbdab641402d16904611ce7
- 0x81a97e01dd276dcb0bd61dcc6965b9171da3f7a89e73eee949dff901709de3c0
- 0x1118544be68b67f9fda3d8e834f3230be756f44f989e2391461320de44fb519e
- 0xf8c786c2c56d21d90edbd5c6397815b003b0c88aa76eefdb5acc1f60476d8804
```
