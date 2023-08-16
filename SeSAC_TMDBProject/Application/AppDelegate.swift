//
//  AppDelegate.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        NetworkManager.shared.callResponse(api: .genre(media: .movie)) { (list: GenreList) in
            list.genres.forEach {
                GenreList.movie[$0.id] = $0.name
            }
        }
        NetworkManager.shared.callResponse(api: .genre(media: .tv)) { (list: GenreList) in
            list.genres.forEach {
                GenreList.tv[$0.id] = $0.name
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

