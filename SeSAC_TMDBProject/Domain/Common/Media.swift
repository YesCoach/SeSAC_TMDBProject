//
//  Media.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/16.
//

import Foundation

protocol Media: Codable {
    var id: Int { get }
    var adult: Bool { get }
    var title: String { get }
    var backdropPath: String { get }
    var originalLanguage: String { get }
    var originalTitle: String { get }
    var overview: String { get }
    var posterPath: String { get }
    var genreIDs: [Int] { get }
    var popularity: Double { get }
    var releaseDate: String { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
    var mediaType: APIURL.TMDB.MediaType { get }

    var posterURL: String { get }
    var backdropURL: String { get }
}

protocol MediaResult {
    var page: Int { get }
    var results: [Media] { get }
    var totalPages: Int { get }
    var totalResults: Int { get }
}
