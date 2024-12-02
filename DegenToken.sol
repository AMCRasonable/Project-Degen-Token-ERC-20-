// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenGamingToken is ERC20, Ownable {
    string private constant _tokenName = "Degen";
    string private constant _tokenSymbol = "DGN";

    struct Outfit {
        string name;
        uint256 price;
    }

    Outfit[] public outfits;

    constructor(address initialOwner) ERC20(_tokenName, _tokenSymbol) Ownable(initialOwner) {
        outfits.push(Outfit("Klee Summer Dress", 500));   
        outfits.push(Outfit("Albedo Office Outfit", 500));  
        outfits.push(Outfit("Zhongli Pajamas", 700));   
        outfits.push(Outfit("Diluc Forwal Wear", 650));   
        outfits.push(Outfit("Venti School Uniform", 600));   
    }

    // Function to mint tokens (only owner can mint)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function for players to redeem tokens for an outfit
    function redeem(uint256 outfitId) public {
        require(outfitId < outfits.length, "Invalid outfit ID");
        Outfit memory outfit = outfits[outfitId]; 
        require(balanceOf(msg.sender) >= outfit.price, "Insufficient balance to redeem this outfit");
        
        // Burn the required amount of tokens for the outfit
        _burn(msg.sender, outfit.price);
    }

    // Function to get the total count of available outfits
    function getOutfitsCount() public view returns (uint256) {
        return outfits.length;
    }

    // Function to get the details (name and price) of a specific outfit by ID
    function getOutfit(uint256 outfitId) public view returns (string memory outfitName, uint256 price) {
        require(outfitId < outfits.length, "Invalid outfit ID");
        Outfit storage outfit = outfits[outfitId];
        return (outfit.name, outfit.price);
    }

    // Function for players to transfer tokens to other addresses
    function transferTokens(address recipient, uint256 amount) public returns (bool) {
        return transfer(recipient, amount);
    }

    // Function to burn tokens (any user)
    function burn(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to burn tokens");
        _burn(msg.sender, amount);
    }
}

// other accouont: 0x82A81dA50647650D67BeDab571A318475F0887a0
