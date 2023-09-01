//
//  NetworkResponse.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/09/01.
//

import Foundation

struct NetworkResponseData<T: Codable>: Codable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [T]

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
