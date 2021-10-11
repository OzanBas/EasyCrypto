//
//  UserConfig.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 7.10.2021.
//

import Foundation


var selectionKey = "selection_list"


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
}

