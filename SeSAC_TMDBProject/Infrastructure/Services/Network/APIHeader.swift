//
//  APIHeader.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation
import Alamofire


enum APIHeader {

    enum TMDB {
        static let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "\(APIKey.tmdbAccessToken)"
        ]
    }

}
