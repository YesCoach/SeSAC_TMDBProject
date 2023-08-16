//
//  Movie.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation

struct Movie: Media {
    let id: Int
    let adult: Bool
    let title: String
    let backdropPath: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let genreIDs: [Int]
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
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
    }

    /// posterPath를 적용한 이미지 URL을 반환합니다.
    var posterURL: String {
        return "https://image.tmdb.org/t/p/original\(posterPath)"
    }

    var backdropURL: String {
        return "https://image.tmdb.org/t/p/original\(backdropPath)"
    }
}
