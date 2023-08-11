//
//  NetworkManager.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NetworkManager {

    static let shared = NetworkManager()

    private init() { }
}

extension NetworkManager {

    func callResponse(api: APIURL.TMDB) {

        let url = api.url
        let header = APIHeader.TMDB.header

        AF.request(url, method: .get, headers: header)
            .validate()
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }

    }
}
