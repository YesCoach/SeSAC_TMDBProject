//
//  Movie.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation

// MARK: - Movie

struct Movie: MovieType {
    let id: Int
    let adult: Bool
    let title: String?
    let originalTitle: String?
    let originalLanguage: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let genreIDs: [Int]?
    let popularity: Double
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let mediaType: APIURL.TMDB.MediaType

    enum CodingKeys: String, CodingKey {
        case id, title, adult, overview, popularity
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
    }
}
