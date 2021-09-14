//
//  FavoriteCoins.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 31.08.2021.
//

import UIKit




struct CoinData : Decodable {
    var id: String?
    var name: String?
    var image: String?
    var current_price: Double?
    var market_cap_rank: Int?
}


var coinList : [CoinData] = []












//var coinList : [CoinModel] = [
//    CoinModel(name: "Bitcoin", logo: #imageLiteral(resourceName: "bitcoin-btc-logo"), favorite: false),
//    CoinModel(name: "Polkadot", logo: #imageLiteral(resourceName: "polkadot-new-dot-logo"), favorite: false),
//    CoinModel(name: "Uniswap", logo: #imageLiteral(resourceName: "uniswap-uni-logo"), favorite: false),
//    CoinModel(name: "Cardano", logo: #imageLiteral(resourceName: "cardano-ada-logo"), favorite: false),
//    CoinModel(name: "Binance Coin", logo: #imageLiteral(resourceName: "binance-coin-bnb-logo"), favorite: false),
//    CoinModel(name: "Tether", logo: #imageLiteral(resourceName: "tether-usdt-logo"), favorite: false),
//    CoinModel(name: "Litecoin", logo: #imageLiteral(resourceName: "litecoin-ltc-logo"), favorite: false),
//    CoinModel(name: "Ethereum", logo: #imageLiteral(resourceName: "ethereum-eth-logo"), favorite: false),
//    CoinModel(name: "Doge", logo: #imageLiteral(resourceName: "dogecoin-doge-logo"), favorite: false),
//    CoinModel(name: "Ripple", logo: #imageLiteral(resourceName: "xrp-xrp-logo"), favorite: false)
//]


