//
//  ProductionCountry.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import Foundation

// MARK: - ProductionCountry

struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}
