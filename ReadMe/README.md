# Setup
Initialize Project 
```shell
yarn init -y
```
Install Hardhat
```shell
yarn add --dev hardhat
```
Run Hardhat
```shell
yarn hardhat
```
* Add .js sample project

```shell
 npm install -g solhint 
 solhint --init   
```
Install solhint and initialize `_solhint.json_`

```shell
 yarn add --dev prettier-plugin-solidity
```
Install prettier-plugin for solidity
```shell
yarn add @chainlink/contracts
```
Install chainLink for `_PriceConvertor.sol_`
```shell
yarn add --dev hardhat-deploy 
```

Install hardhat-deploy plugin , also add import it into `hardhat.config.js`
```js
require("hardhat-deploy")
```

Install ethers.js deployment plugin
```shell
yarn add --dev @nomiclabs/hardhat-ethers@npm:hardhat-deploy-ethers ethers
```
Overrirde hardhat-deploy-ethers // to resume `getContract`
```shell
yarn add @nomiclabs/hardhat-ethers@npm:hardhat-deploy-ethers  
```
update the interactive 
```shell
yarn upgrade-interactive  
```
