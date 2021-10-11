//
//  ListViewModel.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 24.09.2021.
//

import UIKit


struct ListViewModel : Hashable, Codable {
    
    var name: String?
    var image: String?
    var id: String?
    var current_price : Double?
    var isFavorite : Bool
    var priceStasus : String
    var symbol: String?
    var price_change_percentage_24h : Double?
    var percentageStasus : String
}


let ListViewApiUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"

var ListViewArray : [ListViewModel] =  [] {
    didSet {
        if ListViewArray.count == 99 {
            filteredListViewArray = ListViewArray
            gainersArray = ListViewArray
            adjustGainers(array: gainersArray)
            losersArray = ListViewArray
            adjustLosers(array: losersArray)
        }
    }
}

var searchArray : [ListViewModel] = []

var losersArray : [ListViewModel] = []

var gainersArray : [ListViewModel] = []

var favsViewArray : [ListViewModel] = []

var filteredListViewArray : [ListViewModel] = []



func adjustLosers(array: [ListViewModel]) {
    let sorted = losersArray.sorted(by: {$0.price_change_percentage_24h ?? 0 < $1.price_change_percentage_24h ?? 0})
    let capped: [ListViewModel] = Array(sorted[0..<10])
    losersArray = capped
}


func adjustGainers(array: [ListViewModel]) {
    let sorted = gainersArray.sorted(by: {$0.price_change_percentage_24h ?? 0 > $1.price_change_percentage_24h ?? 0})
    let capped: [ListViewModel] = Array(sorted[0..<10])
    gainersArray = capped
}


func updateFavsArray() {
    favsViewArray = ListViewArray.filter{$0.isFavorite == true}
    
    saveSelections()
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
