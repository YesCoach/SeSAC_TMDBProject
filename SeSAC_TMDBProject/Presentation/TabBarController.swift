//
//  TabBarController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

class TabBarController: UITabBarController {

    private let mainViewController = MainViewController()
    private let mapViewController = MapViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewControllers = [
            UINavigationController(rootViewController: MainViewController()),
            UINavigationController(rootViewController: MapViewController())
        ]

        view.backgroundColor = .systemBackground
        self.viewControllers = viewControllers
    }
}
