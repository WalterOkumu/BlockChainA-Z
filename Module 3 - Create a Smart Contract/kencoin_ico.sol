// KenCoins ICO

// Version of Compiler
pragma solidity ^0.4.11;

contract kencoin_ico {

    // Introducing the max number of KenCoins available for sale
    uint public max_kencoins = 1000000;

    // Introducing the USD to KenCoin conversion rate
    uint public usd_to_kencoin = 1000;

    // Introducing the total number of KenCoins bought by investors
    uint public total_kencoins_bought = 0;

    // Mapping from the investor address to its equity in KenCoins and USD
    mapping(address => uint) equity_kencoins;
    mapping(address => uint) equity_usd;

    // Checking if an investor can buy KenCoins
    modifier can_buy_kencoins(uint usd_invested) {
        require (usd_invested * usd_to_kencoin + total_kencoins_bought <= max_kencoins);
        _;
    }

    // Getting the equity in KenCoins of an investor
    function equity_in_kencoins(address investor) external constant returns (uint) {
        return equity_kencoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }

    // Buying KenCoins
    function buy_kencoins(address investor, uint usd_invested) external 
    can_buy_kencoins(usd_invested) {
        uint kencoins_bought = usd_invested * usd_to_kencoin;
        equity_kencoins[investor] += kencoins_bought;
        equity_usd[investor] = equity_kencoins[investor] / usd_to_kencoin;
        total_kencoins_bought += kencoins_bought;
    }

    // Selling KenCoins
    function sell_kencoins(address investor, uint kencoins_to_sell) external {
        equity_kencoins[investor] -= kencoins_to_sell;
        equity_usd[investor] = equity_kencoins[investor] / usd_to_kencoin;
        total_kencoins_bought -= kencoins_to_sell;
    }
}
