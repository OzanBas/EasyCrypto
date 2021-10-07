//
//  PriceModel.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 1.10.2021.
//

import Foundation



func priceUpdater() {
    for each in 0..<favsViewArray.count {
        let requestURL = priceUrlCreator(for: favsViewArray[each].id!)
        PriceManager().getPrice(with: requestURL, for: favsViewArray[each].id!)
    }
}

func arrayPriceUpdater(with price : Double, with percentage : Double, for id: String) {
    
    for each in 0...favsViewArray.count-1 {
        if id == favsViewArray[each].id {
            if favsViewArray[each].current_price == price{
                favsViewArray[each].priceStasus = ".white"

            } else if favsViewArray[each].current_price! > price {
                favsViewArray[each].priceStasus = ".red"

            } else if favsViewArray[each].current_price! < price {
                favsViewArray[each].priceStasus = ".green"
            }
            
            favsViewArray[each].current_price = price
        }
    }
    
    for each in 0...favsViewArray.count-1 {
        if id == favsViewArray[each].id {
            if favsViewArray[each].current_price == 0{
                favsViewArray[each].percentageStasus = ".white"

            } else if favsViewArray[each].current_price! < 0 {
                favsViewArray[each].percentageStasus = ".red"

            } else if favsViewArray[each].current_price! > 0 {
                favsViewArray[each].percentageStasus = ".green"
            }
            
            favsViewArray[each].price_change_percentage_24h = percentage
        }
    }
    
}

func priceUrlCreator(for id: String) -> String {
    let string = PriceManager().baseURL
    let url = "\(string)/coins/\(id)"
    return url
}
