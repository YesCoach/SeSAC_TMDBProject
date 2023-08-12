//
//  Movie.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let posterPath: String
    let mediaType: MediaTypes?
    let genreIDs: [Int]?
    let popularity: Double
    let releaseDate: String?
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
        case mediaType = "media_type"
        case genreIDs = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    enum MediaTypes: String, Codable {
        case all
        case movie
        case tv
        case person

        var description: String {
            switch self {
            case .movie: return "영화"
            case .tv: return "TV 프로그램"
            case .person: return "배우"
            default: return "전체"
            }
        }
    }

    /// posterPath를 적용한 이미지 URL을 반환합니다.
    var posterURL: String {
        return "https://image.tmdb.org/t/p/original\(posterPath)"
    }
}
