//
//  Product.swift
//  LodgingCommunity
//
//  Created by 박지현 on 2021/07/02.
//

import Foundation

struct Product: Codable {
    var id: Int
    var name: String
    var thumbnail: String
    var description: Description
    var rate: Double
    var favorite: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id, name, thumbnail, description, rate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        thumbnail = (try? values.decode(String.self, forKey: .thumbnail)) ?? ""
        description = try values.decode(Description.self, forKey: .description)
        rate = (try? values.decode(Double.self, forKey: .rate)) ?? 0
        favorite = (UserDefaults.standard.string(forKey: "\(id)") != nil)
    }
    
    init() {
        id = 0
        name = ""
        thumbnail = ""
        description = Description()
        rate = 0
        favorite = false
    }
}
