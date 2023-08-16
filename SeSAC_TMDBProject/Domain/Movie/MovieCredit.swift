//
//  Credit.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation

struct MovieCredit: Codable {
    let id: Int
    let cast: [Cast]
}

extension MovieCredit {
    enum CodingKeys: String, CodingKey {
        case id, cast
    }
}
