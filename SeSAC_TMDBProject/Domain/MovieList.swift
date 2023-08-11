//
//  MovieList.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let results: [Movie]
}

extension MovieList {

    enum CodingKeys: String, CodingKey {
        case page, results
    }

}
