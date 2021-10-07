//
//  DetailManager.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 5.10.2021.
//

import UIKit


protocol DetailProtocol {
    func setValues()
}

var detailDelegate : DetailProtocol?

var detailsReady : SingleDataModel? {
    didSet {
        detailDelegate?.setValues()
    }
}

class DetailManager {
    
    
    
    var baseURL = "https://api.coingecko.com/api/v3/coins/" //needs: /coins/coinID
    
    
    func getDetails(with url: String) {
        if let request = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { Data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                } else {
                    if let safeData = Data {
                        let decoder = JSONDecoder()
                        do {
                            let apiResult = try decoder.decode(SingleDataModel.self, from: safeData)
                            detailsReady = SingleDataModel(market_data: apiResult.market_data,
                                                           id: apiResult.id,
                                                           symbol: apiResult.symbol,
                                                           description: apiResult.description,
                                                           image: apiResult.image,
                                                           market_cap_rank: apiResult.market_cap_rank,
                                                           name: apiResult.name)
                            
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


