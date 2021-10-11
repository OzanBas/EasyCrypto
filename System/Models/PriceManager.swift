//
//  PriceManager.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 1.10.2021.
//

import UIKit




class PriceManager {
    
    var baseURL = "https://api.coingecko.com/api/v3" //needs: /coins/"coinID"
    
    
    func getPrice(with url: String, for coin: String) {
        if let request = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { Data, response, error in
                if error != nil {
                    print("Error - session.dataTask Failed.")
                    return
                } else {
                    if let safeData = Data {
                        let decoder = JSONDecoder()
                        do {
                            let apiResult = try decoder.decode(SingleDataModel.self,from: safeData)
                            arrayPriceUpdater(with: apiResult.market_data.current_price.usd ?? 0, with: apiResult.market_data.price_change_percentage_24h ?? 0, for: coin)
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

