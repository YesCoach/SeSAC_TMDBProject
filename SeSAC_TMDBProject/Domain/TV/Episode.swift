//
//  Episode.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/16.
//

import Foundation

// MARK: - Episode

struct Episode: Codable {
    let airDate: String?
    let episodeNumber: Int?
    let episodeType: String?
    let id: Int
    let name: String
    let overview: String?
    let productionCode: String?
    let runtime: Int?
    let seasonNumber: Int?
    let showID: Int?
    let stillPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    let crew: [Crew]?

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

extension Episode {
    var imageURL: String? {
        if let stillPath {
            return "https://image.tmdb.org/t/p/original\(stillPath)"
        } else { return nil }
    }
}
