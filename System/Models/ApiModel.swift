//
//  FavoriteCoins.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 31.08.2021.
//

import UIKit

struct ApiModel : Hashable, Codable {
    var id: String?
    var name: String?
    var image: String?
    var current_price: Double?
    var market_cap_rank: Int?
    var symbol: String?
    var price_change_percentage_24h : Double?
    
}


