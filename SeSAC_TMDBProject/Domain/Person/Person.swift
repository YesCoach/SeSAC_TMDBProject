//
//  Person.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/09/01.
//

import Foundation

// MARK: - Person
struct PersonResult: Codable {
    var page: Int?
    var results: [Person]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Person: PersonType {
    var adult: Bool
    var id: Int
    var name, originalName: String?
    var popularity: Double
    var gender: Int?
    var knownForDepartment: String?
    var profilePath: String?
    var knownFor: [Work]?
    var mediaType: MediaType?

    enum CodingKeys: String, CodingKey {
        case adult, id, name
        case originalName = "original_name"
        case mediaType = "media_type"
        case popularity, gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

// MARK: - Work
struct Work: Codable {
    var adult: Bool?
    var backdropPath: String?
    var id: Int?
    var title, originalLanguage, originalTitle, overview: String?
    var posterPath, mediaType: String?
    var genreIDS: [Int]?
    var popularity: Double?
    var releaseDate: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var name, originalName, firstAirDate: String?
    var originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

extension Work {
    /// posterPath를 적용한 이미지 URL을 반환합니다.
    var posterURL: String {
        return "https://image.tmdb.org/t/p/original\(posterPath ?? "")"
    }

    /// backdropPath를 적용한 이미지 URL을 반환합니다.
    var backdropURL: String {
        return "https://image.tmdb.org/t/p/original\(backdropPath ?? "")"
    }
}
