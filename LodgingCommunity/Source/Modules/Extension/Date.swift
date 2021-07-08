//
//  Date.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/04.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: self)
    }
}
