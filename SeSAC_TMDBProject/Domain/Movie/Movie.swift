//
//  Movie.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation

// MARK: - MovieResult

struct MovieResult: MediaResult {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

extension MovieResult {

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}

// MARK: - Movie

struct Movie: Media {
    let id: Int
    let adult: Bool
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let genreIDs: [Int]
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let mediaType: APIURL.TMDB.MediaType?
}

extension Movie {

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
