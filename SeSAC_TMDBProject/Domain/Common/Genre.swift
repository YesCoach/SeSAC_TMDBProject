//
//  Genre.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/13.
//

import Foundation

struct GenreList: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}

extension GenreList {
    static var movie: [Int: String] = [:]
    static var tv: [Int: String] = [:]
}
