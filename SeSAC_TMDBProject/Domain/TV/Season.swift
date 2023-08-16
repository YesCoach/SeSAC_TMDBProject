//
//  Season.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/16.
//

import Foundation

// MARK: - SeasonDetails

struct Season: Codable {
    let id, airDate: String
    let episodes: [Episode]
    let name, overview: String
    let seasonDetailsID: Int
    let posterPath: String
    let seasonNumber, voteAverage: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes, name, overview
        case seasonDetailsID = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}
