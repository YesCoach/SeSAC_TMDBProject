//
//  EndPoint.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation

enum APIURL {

    enum TMDB {
        // MARK: - API
        case trending(media: MediaType, timeWindow: TimeWindow)

        // MARK: - Movie
        case movieCredit(movieID: Int)

        // MARK: - TV
        case tvCredit(seriesID: Int)
        case tvDetail(seriesID: Int)
        case seasonsDetails(seriesID: Int, seasonNumber: Int)
        case episodesDetails(seriesID: Int, seasonNumber: Int, episodeNumber: Int)

        // MARK: - Genre
        case genre(media: GenreType)
    }

    enum Language: String {
        case ko = "ko-KR"
        case en = "en-US"
        case jn = "jn-JP"
    }
}

extension APIURL.TMDB {

    enum TimeWindow: String {
        case day
        case week
    }

    enum MediaType: String, Codable {
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

    enum GenreType: String, Codable {
        case movie
        case tv
    }

    private var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }

    private var languageQuery: String {
        return "?language=\(APIURL.Language.ko.rawValue)"
    }


    var url: String {
        switch self {
        // MARK: - Trend
        case .trending(let media, let timeWindow):
            return baseURL + "trending/\(media.rawValue)/\(timeWindow.rawValue)\(languageQuery)"

        // MARK: - Movie
        case .movieCredit(let movieID):
            return baseURL + "movie/\(movieID)/credits"

        // MARK: - TV
        case .tvCredit(let seriesID):
            return baseURL + "tv/\(seriesID)/credits"
        case .tvDetail(let seriesID):
            return baseURL + "tv/\(seriesID)\(languageQuery)"
        case .seasonsDetails(let seriesID, let seasonNumber):
            return baseURL + "tv/\(seriesID)/season/\(seasonNumber)"
        case .episodesDetails(let seriesID, let seasonNumber, let episodeNumber):
            return baseURL + "tv/\(seriesID)/season/\(seasonNumber)/episode/\(episodeNumber)"

        // MARK: - Genre
        case .genre(let type):
            return baseURL + "genre/\(type.rawValue)/list\(languageQuery)"
        }
    }
}
