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
        case credit(movieID: Int)

        // MARK: - TV
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

    enum MediaType: String {
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

    enum GenreType: String {
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
        case .credit(let movieID):
            return baseURL + "movie/\(movieID)/credits"

        // MARK: - TV
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
