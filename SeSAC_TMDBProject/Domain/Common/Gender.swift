//
//  Gender.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/09/01.
//

import Foundation

enum Gender: Int {
    case notSpecified
    case female
    case male
    case nonBinary

    var description: String {
        switch self {
        case .notSpecified: return "젠더리스"
        case .female: return "여성"
        case .male: return "남성"
        case .nonBinary: return "논바이너리"
        }
    }
}
