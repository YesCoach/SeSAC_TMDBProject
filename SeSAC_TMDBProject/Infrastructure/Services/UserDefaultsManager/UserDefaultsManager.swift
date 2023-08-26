//
//  UserDefaultsManager.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/27.
//

import Foundation

final class UserDefaultsManager {

    private init () { }

    enum UserDefaultsKey: String {
        case isLaunchedKey
    }

    @UserDefault(key: UserDefaultsKey.isLaunchedKey.rawValue, defaultValue: false)
    /// 최초 앱 실행 여부 값입니다. false일 경우 앱의 첫 화면으로 이동합니다.
    static var isLaunched: Bool

}
