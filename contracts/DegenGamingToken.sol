// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenGamingToken is ERC20, Ownable {
    uint256[] internal itemIds;
    mapping(uint256 => RedeemableItem) public items;
    mapping(address => bool) public  isBlacklisted;

    event ItemRedeemed(address indexed redeemer, uint256 indexed itemId);

    struct RedeemableItem {
        string name;
        uint256 cost;
    }

    constructor(uint256 initialSupply) ERC20("DegenGamingToken", "DGT") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }

    function mint(address _to, uint256 _value) external onlyOwner {
        _mint(_to, _value);
    }

    function decimals() public pure override  returns (uint8) {
        return 0;
    }

    function transferToken(address _recipient, uint256 _amount) external returns (bool) {
        require(!isBlacklisted[msg.sender], "Sender is blacklisted");
        require(!isBlacklisted[_recipient], "Recipient is blacklisted");
        require(balanceOf(msg.sender) >= _amount, "Insufficient balance");

        _transfer(msg.sender, _recipient, _amount);

        return true;
    }

    function addItem(string memory _name, uint256 _cost) external onlyOwner {
        RedeemableItem memory newItem = RedeemableItem({
            name: _name,
            cost: _cost
        });

        // The key for this item is the current length of the itemIds array.
        items[itemIds.length] = newItem;

        itemIds.push(itemIds.length);
    }
    
    function redeem(uint256 _itemId) external {
        require(items[_itemId].cost >  0, "Item does not exist");
        require(balanceOf(msg.sender) >= items[_itemId].cost, "Insufficient balance");

        // Transfer the tokens from the sender to the contract (burning them)
        _transfer(msg.sender, address(this), items[_itemId].cost);

        delete items[_itemId];

        emit ItemRedeemed(msg.sender, _itemId);
    }

    function burnToken(uint256 _value) external {
        _burn(msg.sender, _value);
    }

    function blacklist(address _account) external onlyOwner {
        isBlacklisted[_account] = true;
    }

    function unblacklist(address _account) external onlyOwner {
        isBlacklisted[_account] = false;
    }
}
