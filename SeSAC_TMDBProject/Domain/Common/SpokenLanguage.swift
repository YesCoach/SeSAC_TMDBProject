//
//  SpokenLanguage.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import Foundation

// MARK: - SpokenLanguage

struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
