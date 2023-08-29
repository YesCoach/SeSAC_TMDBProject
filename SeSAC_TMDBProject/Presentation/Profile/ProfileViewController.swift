//
//  ProfileViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

final class ProfileViewController: BaseViewController {

    private lazy var mainView: ProfileView = ProfileView(user: user)
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "설정",
            style: .plain,
            target: self,
            action: #selector(didRightBarButtonTouched)
        )
        return barButtonItem
    }()

    private var user = User(profileImageURL: nil, name: "예스코치", introduce: "smu ios dev 🍎")

    override func loadView() {
        self.view = mainView
    }

    override func configureNavigationItem() {
        super.configureNavigationItem()
        navigationController?.navigationBar.tintColor = .systemMint
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func didRightBarButtonTouched(_ sender: UIBarButtonItem) {

        let rootViewController = ProfileEditViewController(user: user)
        rootViewController.delegate = self
        let viewController = UINavigationController(
            rootViewController: rootViewController
        )
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen

        present(viewController, animated: true)
    }
}

extension ProfileViewController: ProfileEditViewControllerDelegate {

    func updateUserProfile(user: User) {
        mainView.configure(with: user)
    }
}
