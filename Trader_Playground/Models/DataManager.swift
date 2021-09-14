//
//  FetchData.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 31.08.2021.
//

import UIKit

class DataManager {
    
    
    let apiUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"
    
    
    func getData(with url: String) {
        if let request = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { Data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                } else {
                    if let safeData = Data {
                        self.parseJSON(apiData: safeData)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(apiData: Data) {
        let decoder = JSONDecoder()
        do {
            let apiResult = try decoder.decode([CoinData].self, from: apiData)
            for item in apiResult {
                coinList.append(CoinData(id: item.id, name: item.name, image: item.image, current_price: item.current_price, market_cap_rank: item.market_cap_rank))
            }
            
            for item in coinList {
                coinModel.append(CoinModel(coinData: item, favorite: false))
            }
            
        } catch {
            print(error)
        }
    }
    
}
