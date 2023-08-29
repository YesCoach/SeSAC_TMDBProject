//
//  ProfileEditViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

final class ProfileEditViewController: BaseViewController {

    private lazy var mainView = ProfileEditView()

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

    override func loadView() {
        self.view = mainView
    }

    override func configureNavigationItem() {
        super.configureNavigationItem()
        navigationController?.navigationBar.tintColor = .systemMint
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    override func configureView() {
        super.configureView()
        mainView.nameTextField.delegate = self
        mainView.introduceTextField.delegate = self
    }

    @objc func didCompleteButtonTouched(_ sender: UIBarButtonItem) {

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
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
