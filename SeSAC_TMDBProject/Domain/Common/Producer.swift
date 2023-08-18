//
//  Producer.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import Foundation

// MARK: - Producer

struct Producer: Codable {
    let id: Int
    let creditID: String
    let name: String
    let gender: Int
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}
