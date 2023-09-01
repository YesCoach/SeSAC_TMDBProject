//
//  NetworkManager.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation
import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()

    private init() { }
}

extension NetworkManager {

    func callResponse<T: Codable>(api: APIURL.TMDB, completionHandler: @escaping (T) -> ()) {

        let url = api.url
        let header = APIHeader.TMDB.header

        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...299)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(data)
                case .failure(let error):
                    print(url)
                    debugPrint(error)
                }
            }
    }

}
