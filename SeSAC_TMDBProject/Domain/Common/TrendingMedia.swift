//
//  Media.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/16.
//

import Foundation

protocol TrendingMediaType: Codable {
    var id: Int { get }
    var adult: Bool { get }
    var popularity: Double { get }
    var mediaType: MediaType? { get }
}

protocol MediaContentsType: TrendingMediaType {
    var originalLanguage: String? { get }
    var overview: String? { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var genreIDs: [Int]? { get }
    var releaseDate: String? { get }
    var voteAverage: Double? { get }
    var voteCount: Int? { get }
    var title: String? { get }
    var originalTitle: String? { get }
}

protocol MovieType: MediaContentsType { }

protocol TVType: MediaContentsType {
    var originCountry: [String]? { get }
}

protocol PersonType: TrendingMediaType {
    var gender: Int? { get }
    var knownForDepartment: String? { get }
    var profilePath: String? { get }
    var knownFor: [Work]? { get }
    var name: String? { get }
    var originalName: String? { get }
}

enum MediaType: String, Codable {
    case movie
    case tv
    case person
}

struct TrendingMedia: PersonType, MovieType, TVType {
    // MediaType
    var id: Int
    var adult: Bool
    var popularity: Double
    var mediaType: MediaType?
    // PersonType
    var name: String?
    var originalName: String?
    var gender: Int?
    var knownForDepartment: String?
    var profilePath: String?
    var knownFor: [Work]?
    // MediaContentsType
    var title: String?
    var originalTitle: String?
    var originalLanguage: String?
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var genreIDs: [Int]?
    var releaseDate: String?
    var voteAverage: Double?
    var voteCount: Int?
    // TVType
    var originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case adult
        case popularity
        case mediaType = "media_type"
        case gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case knownFor = "known_for"
        case backdropPath = "backdrop_path"
        case title
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
        case releaseDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}

extension TrendingMedia {

    func getConcreteModel() -> TrendingMediaType {
        if mediaType == .movie {
            return Movie(
                id: id, adult: adult, title: title, originalTitle: originalTitle,
                originalLanguage: originalLanguage, overview: overview, posterPath: posterPath,
                backdropPath: backdropPath, genreIDs: genreIDs, popularity: popularity,
                releaseDate: releaseDate, voteAverage: voteAverage, voteCount: voteCount,
                mediaType: mediaType
            )
        } else if mediaType == .tv {
            return TV(
                id: id, adult: adult, backdropPath: backdropPath, title: name,
                originalTitle: originalName, overview: overview, posterPath: posterPath,
                genreIDs: genreIDs, popularity: popularity, releaseDate: releaseDate,
                voteAverage: voteAverage, voteCount: voteCount, originCountry: originCountry,
                originalLanguage: originalLanguage, mediaType: mediaType
            )
        } else {
            return Person(
                adult: adult, id: id, name: name, originalName: originalName,
                popularity: popularity, gender: gender, knownForDepartment: knownForDepartment,
                profilePath: profilePath, knownFor: knownFor, mediaType: mediaType
            )
        }
    }

}

extension MediaContentsType {
    /// posterPath를 적용한 이미지 URL을 반환합니다.
    var posterURL: String {
        return "https://image.tmdb.org/t/p/original\(posterPath ?? "")"
    }

    /// backdropPath를 적용한 이미지 URL을 반환합니다.
    var backdropURL: String {
        return "https://image.tmdb.org/t/p/original\(backdropPath ?? "")"
    }
}

extension PersonType {
    /// profilePath를 적용한 이미지 URL을 반환합니다.
    var profileURL: String {
        return "https://image.tmdb.org/t/p/original\(profilePath ?? "")"
    }
}
