//
//  TV.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/16.
//

import Foundation

// MARK: - TV
struct TV: TVType {
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let genreIDs: [Int]?
    let popularity: Double
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let originCountry: [String]?
    let originalLanguage: String?
    let mediaType: APIURL.TMDB.MediaType
}

extension TV {

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case title = "name"
        case originalLanguage = "original_language"
        case originalTitle = "original_name"
        case overview
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
        case popularity
        case releaseDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
        case mediaType = "media_type"
    }

}
