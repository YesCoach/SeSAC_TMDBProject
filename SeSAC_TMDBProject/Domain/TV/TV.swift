//
//  TV.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/16.
//

import Foundation

// MARK: - TVResult

// TODO: - MovieResult랑 TVResult이 같은 타입을 채택하게 할 수 없을까? Polymolphism ?
struct TVResult: Codable {

    let page: Int
    let results: [TV]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - TV
struct TV: Media {



    let id: Int
    let adult: Bool
    let backdropPath: String
    let title: String
    let originalLanguage: String
    let originalTitle, overview, posterPath: String
    let genreIDs: [Int]
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]
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

    var posterURL: String {
        return "https://image.tmdb.org/t/p/original\(posterPath)"
    }

    var backdropURL: String {
        return "https://image.tmdb.org/t/p/original\(backdropPath)"
    }
}
