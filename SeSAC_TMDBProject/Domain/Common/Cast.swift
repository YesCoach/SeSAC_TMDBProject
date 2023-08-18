//
//  Cast.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import Foundation

struct Cast: Codable {
    let id: Int
    let castID: Int?
    let castName: String
    let characterName: String
    let profilePath: String?
}

extension Cast {

    /// profilePath를 적용한 이미지 URL을 반환합니다.
    var imageURL: String? {
        guard let profilePath
        else { return nil }
        return "https://image.tmdb.org/t/p/original\(profilePath)"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case castID = "cast_id"
        case castName = "name"
        case characterName = "character"
        case profilePath = "profile_path"
    }
}
