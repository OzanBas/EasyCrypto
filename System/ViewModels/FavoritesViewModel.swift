//
//  FavoritesViewModel.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 25.09.2021.
//

import UIKit


struct FavoritesViewModel : Hashable {
    var name: String?
    var image: String?
    var current_price: Double?
    var isFavorite : Bool
}
