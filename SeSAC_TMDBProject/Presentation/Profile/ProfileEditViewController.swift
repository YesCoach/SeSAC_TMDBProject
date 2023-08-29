//
//  ProfileEditViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

protocol ProfileEditViewControllerDelegate {
    func updateUserProfile(user: User)
}

final class ProfileEditViewController: BaseViewController {

    // MARK: - UIComponents

    private lazy var mainView = ProfileEditView(user: user)

    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(didCompleteButtonTouched)
        )
        return barButtonItem
    }()
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(didCancelButtonTouched)
        )
        return barButtonItem
    }()

    // MARK: - Properties

    private var user: User
    var delegate: ProfileEditViewControllerDelegate?

    // MARK: - Initialize

    init(user: User) {
        self.user = user
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
        super.configureNavigationItem()
        navigationController?.navigationBar.tintColor = .systemMint
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.backButtonTitle = ""
    }

    override func configureView() {
        super.configureView()
        mainView.nameTextField.delegate = self
        mainView.introduceTextField.delegate = self
    }

    // MARK: - Actions

    @objc func didCompleteButtonTouched(_ sender: UIBarButtonItem) {
        guard mainView.nameTextField.text?.isEmpty == false else {
            print("이름은 공백일 수 없습니다. 에러처리하기")
            return
        }
        user.name = mainView.nameTextField.text
        user.introduce = mainView.introduceTextField.text

        delegate?.updateUserProfile(user: user)
        dismiss(animated: true)
    }

    @objc func didCancelButtonTouched(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if let editType = EditType(rawValue: textField.tag) {
            let viewController = ProfileEditDetailViewController(
                editType: editType,
                text: textField.text
            )
            viewController.completionHandler = {text in
                textField.text = text
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
