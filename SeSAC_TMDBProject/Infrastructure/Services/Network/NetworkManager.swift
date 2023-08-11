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

    func callResponse(api: APIURL.TMDB, completionHandler: @escaping (MovieList) -> ()) {

        let url = api.url
        let header = APIHeader.TMDB.header

        AF.request(url, method: .get, headers: header)
            .validate()
            .responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }

                do {
                    let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                    completionHandler(movieList)
                } catch {
                    print(error)
                }

            case .failure(let error):
                print(error)
            }
        }

    }
}
