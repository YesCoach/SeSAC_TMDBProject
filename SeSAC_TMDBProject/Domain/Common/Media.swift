//
//  Media.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/16.
//

import Foundation

protocol MediaResult: Codable {
    associatedtype Media

    var page: Int { get }
    var results: [Media] { get }
    var totalPages: Int { get }
    var totalResults: Int { get }
}

protocol Media: Codable {
    var id: Int { get }
    var adult: Bool { get }
    var title: String { get }
    var originalTitle: String { get }
    var originalLanguage: String { get }
    var overview: String { get }
    var posterPath: String { get }
    var backdropPath: String { get }
    var genreIDs: [Int] { get }
    var popularity: Double { get }
    var releaseDate: String { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
    var mediaType: APIURL.TMDB.MediaType { get }

}

extension Media {
    /// posterPath를 적용한 이미지 URL을 반환합니다.
    var posterURL: String {
        return "https://image.tmdb.org/t/p/original\(posterPath)"
    }

    /// backdropPath를 적용한 이미지 URL을 반환합니다.
    var backdropURL: String {
        return "https://image.tmdb.org/t/p/original\(backdropPath)"
    }
}
