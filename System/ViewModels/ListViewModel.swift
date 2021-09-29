//
//  ListViewModel.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 24.09.2021.
//

import UIKit


struct ListViewModel : Hashable{
    var name: String?
    var image: String?
    var id: String?
    var current_price : Double?
    var isFavorite : Bool

}

var ListViewArray : [ListViewModel] =  []


