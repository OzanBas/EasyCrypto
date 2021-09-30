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
    
}
var selectionKey = "selection_list"

var ListViewArray : [ListViewModel] =  []

var favsViewArray : [ListViewModel] = []

func handleDataArray() {
    favsViewArray = ListViewArray.filter{$0.isFavorite == true}
    saveSelections()
    print(favsViewArray.count)
}

func saveSelections() {
    if let encodedData = try? JSONEncoder().encode(favsViewArray) {
        UserDefaults.standard.set(encodedData, forKey: selectionKey)
    }
}

func getSelections() {
    guard let data = UserDefaults.standard.data(forKey: selectionKey),
          let decodedData = try? JSONDecoder().decode([ListViewModel].self, from: data) else {
              return
          }
    favsViewArray = decodedData
    print("userdefaults get count: \(favsViewArray.count)")
}

