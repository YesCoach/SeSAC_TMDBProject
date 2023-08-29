//
//  ProfileEditDetailViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

enum EditType: Int {
    case name
    case introduce

    var description: String {
        switch self {
        case .name: return "이름"
        case .introduce: return "소개"
        }
    }
}

final class ProfileEditDetailViewController: BaseViewController {

    // MARK: - UIComponents

    private lazy var mainView: ProfileEditDetailView = ProfileEditDetailView(
        editType: editType,
        text: text
    )
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(didConfirmButtonClicked)
        )
        return barButtonItem
    }()

    private let editType: EditType
    private let text: String?

    // MARK: - Initializers


    init(editType: EditType, text: String?) {
        self.editType = editType
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func loadView() {
        self.view = mainView
    }

    override func configureNavigationItem() {
        navigationItem.title = editType.description
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    // MARK: - Actions

    @objc func didConfirmButtonClicked(_ sender: UIBarButtonItem) {

    }
}
