//
//  Crew.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import Foundation

// MARK: - Crew

struct Crew: Codable {
    let job: String
    let department: String
    let creditID: String
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: String
    let name, originalName: String
    let popularity: Double
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case job, department
        case creditID = "credit_id"
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
    }
}
