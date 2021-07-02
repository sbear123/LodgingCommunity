//
//  Favorite.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/02.
//

import Foundation

class Favorite: Codable {
    var isFavorite: Bool
    var selectTime: String
    
    init() {
        isFavorite = false
        selectTime = ""
    }
}
