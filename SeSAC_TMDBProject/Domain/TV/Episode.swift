//
//  Episode.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/16.
//

import Foundation

// MARK: - Episode

struct Episode: Codable {
    let airDate: String
    let episodeNumber: Int
    let episodeType: String
    let id: Int
    let name: String
    let overview: String
    let productionCode: String
    let runtime: Int?
    let seasonNumber, showID: Int
    let stillPath: String?
    let voteAverage, voteCount: Int
    let crew: [Crew]

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case id, name, overview
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case crew
    }
}

// MARK: - Crew
struct Crew: Codable {
    let job: Job
    let department: Department
    let creditID: String
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: Department
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

enum Department: String, Codable {
    case directing = "Directing"
    case writing = "Writing"
}

enum Job: String, Codable {
    case director = "Director"
    case screenplay = "Screenplay"
}
