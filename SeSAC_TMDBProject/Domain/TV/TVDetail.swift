//
//  TVDetail.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import Foundation

// MARK: - TVDetail

struct TVDetail: Codable {
    let adult: Bool
    let backdropPath: String
    let createdBy: [Producer]
    let firstAirDate: String
    let genres: [Genre]
    let homepage: String
    let id: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String
    let lastEpisodeToAir: Episode?
    let name: String
    let nextEpisodeToAir: Episode?
    let networks: [ProductionCompany]
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let seasons: [TVDetail.Season]
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let tagline: String
    let type: String
    let voteAverage: Double?
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    struct Season: Codable {
        let id: Int
        let airDate: String?
        let episodeCount: Int?
        let name: String?
        let overview: String?
        let posterPath: String?
        let seasonNumber: Int
        let voteAverage: Double?

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case airDate = "air_date"
            case episodeCount = "episode_count"
            case name
            case overview
            case posterPath = "poster_path"
            case seasonNumber = "season_number"
            case voteAverage = "vote_average"
        }
    }
}

