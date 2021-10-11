//
//  SearchManager.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 11.10.2021.
//

import UIKit


protocol SearchManagerDelegate {
    func didFinishSearching()
}




class SearchManager {
    
    var searchDelegate : SearchManagerDelegate?
    
    func getData(with url: String) {
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
                            let apiResult = try decoder.decode([ApiModel].self, from: safeData)
                            for item in apiResult {
                                searchArray.append(ListViewModel(name: item.name,
                                                                 image: item.image,
                                                                 id: item.id,
                                                                 current_price: item.current_price,
                                                                 isFavorite: false,
                                                                 priceStasus: ".white",
                                                                 symbol: item.symbol,
                                                                 price_change_percentage_24h: item.price_change_percentage_24h,
                                                                 percentageStasus: ".white"))
                            }
                            self.searchDelegate?.didFinishSearching()
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

