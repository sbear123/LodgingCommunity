//
//  DetailViewModel.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/08.
//

import Foundation

class DetailViewModel {
    let service = DataService.shared
    var productID: Int = 0
    var pro: Product = Product()
    
    func pushFavorite() -> Bool {
        let id = pro.id
        if UserDefaults.standard.string(forKey: "\(id)") == nil {
            let now = Date().toString()
            UserDefaults.standard.set(now, forKey: "\(id)")
            service.currentData.product[productID].favorite = true
            service.refreshFavorite()
            return true
        }
        UserDefaults.standard.removeObject(forKey: "\(id)")
        service.currentData.product[productID].favorite = false
        service.refreshFavorite()
        return false
    }
}
