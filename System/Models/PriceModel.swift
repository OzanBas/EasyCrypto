//
//  PriceModel.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 1.10.2021.
//

import Foundation


struct PriceModel : Decodable{
    var market_data : InitialPrice?
    var id : String?
}
struct InitialPrice : Decodable {
    var current_price : UsdPrice?
}
struct UsdPrice : Decodable {
    var usd : Double?
}




func priceUpdater() {
    for each in 0...favsViewArray.count-1 {
        let requestURL = priceRequestURL(for: favsViewArray[each].id!)
        PriceManager().getPrice(with: requestURL, for: favsViewArray[each].id!)
    }
}

func arrayPriceUpdater(with price : Double, for id: String) {
    for each in 0...favsViewArray.count-1 {
        if id == favsViewArray[each].id {
            favsViewArray[each].current_price = price
        }
    }
}

func priceRequestURL(for id: String) -> String {
    let string = PriceManager().baseURL
    let url = "\(string)/coins/\(id)"
    return url
}
