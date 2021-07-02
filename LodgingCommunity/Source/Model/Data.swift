//
//  Data.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/02.
//

import Foundation

struct Data: Codable {
    var totalCount: Int
    var product: [Product]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount, product
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = (try? values.decode(Int.self, forKey: .totalCount)) ?? 0
        product = (try? values.decode([Product].self, forKey: .totalCount)) ?? []
    }
}
