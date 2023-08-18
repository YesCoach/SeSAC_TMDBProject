//
//  ProductionCompany.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import Foundation

// MARK: - ProductionCompany

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
