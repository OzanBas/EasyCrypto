//
//  DetailModel.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 5.10.2021.
//

import UIKit


struct SingleDataModel : Decodable{
    var market_data : MarketData
    var id : String?
    var symbol: String?
    var description: DescriptionLang
    var image: ImageType
    var market_cap_rank: Int?
    var name: String?
}
struct ImageType: Decodable {
    var large: String?
}
struct DescriptionLang: Decodable {
    var en: String?
}
struct MarketData : Decodable {
    var current_price : CurrentPrice
    var ath: Ath
    var high_24h: High24h
    var low_24h: Low24h
    var price_change_percentage_24h: Double?
    var max_supply: Double?
    var circulating_supply: Double?
    var market_cap: MarketCap
}
struct MarketCap: Decodable {
    var usd: Double?
}
struct High24h: Decodable {
    var usd: Double?
}
struct Low24h: Decodable {
    var usd: Double?
}
struct Ath: Decodable {
    var usd: Double?
}
struct CurrentPrice : Decodable {
    var usd : Double?
}

