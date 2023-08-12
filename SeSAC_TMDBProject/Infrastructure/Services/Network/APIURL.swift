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

        case trending(media: Movie.MediaTypes, timeWindow: TimeWindow)
        case credit(movieID: Int)
    }
}

extension APIURL.TMDB {

    enum TimeWindow: String {
        case day
        case week
    }

    var url: String {
        switch self {
        case .trending(let media, let timeWindow):
            return baseURL + "trending/\(media.rawValue)/\(timeWindow.rawValue)"
        case .credit(let movieID):
            return baseURL + "movie/\(movieID)/credits"
        }
    }

}
