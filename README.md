# Degen Gaming Token

Degen Gaming 🎮, a renowned game studio, has approached you to create a unique token that can reward players and take their game to the next level. You have been tasked with creating a token that can be earned by players in their game and then exchanged for rewards in their in-game store

Try running some of the following tasks:

```shell
yarn install
yarn hardhat node
yarn hardhat run scripts/deploy.ts
```

## Usage

Minting: Call the mint function from your wallet, specifying the recipient and amount. This requires ownership privileges.

Transferring: Call the transferToken function from your wallet, indicating the recipient and amount.

Adding Items: Call the addItem function from your wallet with ownership privileges, providing the item name and cost in DGTs.

Redeeming Items: Call the redeem function from your wallet, specifying the item ID. This will burn the required DGTs from your balance.
