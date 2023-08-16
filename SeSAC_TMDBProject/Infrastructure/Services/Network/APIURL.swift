//
//  EndPoint.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation

enum APIURL {
    enum TMDB {

        private var baseURL: String {
            return "https://api.themoviedb.org/3/"
        }

        case trending(media: MediaTypes, timeWindow: TimeWindow)
        case credit(movieID: Int)
        case genre(media: GenreType)
    }

    enum Language: String {
        case ko = "ko-KR"
        case en = "en-US"
        case jn = "jn-JP"
    }
}

extension APIURL.TMDB {

    var url: String {
        switch self {
        case .trending(let media, let timeWindow):
            return baseURL + "trending/\(media.rawValue)/\(timeWindow.rawValue)?language=\(APIURL.Language.jn.rawValue)"
        case .credit(let movieID):
            return baseURL + "movie/\(movieID)/credits"
        case .genre(let type):
            return baseURL + "genre/\(type.rawValue)/list?language=\(APIURL.Language.jn.rawValue)"
        }
    }

}

extension APIURL.TMDB {

    enum TimeWindow: String {
        case day
        case week
    }


    enum MediaTypes: String {
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

}
