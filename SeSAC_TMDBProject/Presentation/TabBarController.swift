//
//  TabBarController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

final class TabBarController: UITabBarController {

    private let mainViewController = MainViewController()
    private let mapViewController = MapViewController()
    private let profileViewController = ProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewControllers = [
            UINavigationController(rootViewController: mainViewController),
            UINavigationController(rootViewController: mapViewController),
            UINavigationController(rootViewController: profileViewController)
        ]

        mainViewController.tabBarItem = .init(
            title: "트렌드",
            image: .init(systemName: "chart.line.uptrend.xyaxis.circle"),
            selectedImage: .init(systemName: "chart.line.uptrend.xyaxis.circle.fill")
        )

        mapViewController.tabBarItem = .init(
            title: "주변 영화관",
            image: .init(systemName: "mappin.circle"),
            selectedImage: .init(systemName: "mappin.circle.fill")
        )

        profileViewController.tabBarItem = .init(
            title: "내 프로필",
            image: .init(systemName: "person.circle"),
            selectedImage: .init(systemName: "person.circle.fill")
        )

        self.viewControllers = viewControllers

        configureUI()
    }
}

private extension TabBarController {

    func configureUI() {
        tabBar.tintColor = .systemMint
        view.backgroundColor = .systemBackground
    }

}
