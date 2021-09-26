//
//  CoinModel.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 5.09.2021.
//

import UIKit


final class CoinModel {
    var coinData : ApiModel
    var favorite : Bool
    
    init(coinData : ApiModel, favorite : Bool) {
        self.coinData = coinData
        self.favorite = false
    }
    var coinDataBase : [CoinModel] = []
}




