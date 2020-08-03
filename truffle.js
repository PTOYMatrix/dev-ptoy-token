module.exports = {
  networks: {
    ganache: {
      host: '127.0.0.1',
      port: 7545,
      network_id: '*'
    },
    development: {
      host: '10.21.12.121',
      port: 8545,
      network_id: '*'
    },
    'ganache-cli': {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*'
    }
  },
  mocha: {
    useColors: true
  },
  compilers: {
    solc: {
      version: '0.6.2' // ex:  "0.4.20". (Default: Truffle's installed solc)
    }
  }
}