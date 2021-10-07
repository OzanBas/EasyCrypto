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


var selectionKey = "selection_list"



var ListViewArray : [ListViewModel] =  []
var favsViewArray : [ListViewModel] = []


func updateFavsArray() {
    favsViewArray = ListViewArray.filter{$0.isFavorite == true}
    saveSelections()
}

func saveSelections() {
    if let encodedData = try? JSONEncoder().encode(favsViewArray) {
        UserDefaults.standard.set(encodedData, forKey: selectionKey)
    }
}

func loadSelections() {
    guard let data = UserDefaults.standard.data(forKey: selectionKey),
          let decodedData = try? JSONDecoder().decode([ListViewModel].self, from: data) else {
              return
          }
    favsViewArray = decodedData
    print("userdefaults get count: \(favsViewArray.count)")
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
