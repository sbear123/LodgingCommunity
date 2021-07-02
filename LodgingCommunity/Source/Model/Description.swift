//
//  Discription.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/02.
//

import Foundation

struct Description: Codable {
    var imagePath: String
    var subject: String
    var price: Int
    
    private enum CodingKeys: String, CodingKey {
        case imagePath, subject, price
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imagePath = (try? values.decode(String.self, forKey: .imagePath)) ?? ""
        subject = (try? values.decode(String.self, forKey: .subject)) ?? ""
        price = (try? values.decode(Int.self, forKey: .price)) ?? 0
    }
}
