//
//  PhotosCellModel.swift
//  TintHW
//
//  Created by Ting on 2024/3/30.
//

import Foundation

//{
//    "albumId": 1,
//    "id": 1,
//    "title": "accusamus beatae ad facilis cum similique qui sunt",
//    "url": "https://via.placeholder.com/600/92c952",
//    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
//  }

struct PhotosCellModel: Codable {
    var id: String
    var title: String
    var thumbnailUrl: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let idInt = try? container.decode(Int.self, forKey: .id) {
            self.id = String(idInt)
        } else {
            self.id = ""
        }
        
        self.title = try container.decode(String.self, forKey: .title)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
    }
}
