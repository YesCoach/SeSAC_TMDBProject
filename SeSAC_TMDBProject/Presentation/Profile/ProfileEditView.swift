//
//  ProfileEditView.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

final class ProfileEditView: BaseView {

    lazy var profileView: UIImageView = {
        let imageView = UIImageView()

        if let profileImageURL = user.profileImageURL,
           let url = URL(string: profileImageURL)
        {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = .init(systemName: "person.circle.fill")
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .systemMint
        imageView.isUserInteractionEnabled = true

        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = nameLabel.text
        textField.text = user.name
        textField.font = .systemFont(ofSize: 14.0, weight: .regular)
        textField.tag = EditType.name.rawValue
        return textField
    }()

    private lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "소개"
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()

    lazy var introduceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = introduceLabel.text
        textField.text = user.introduce
        textField.font = .systemFont(ofSize: 14.0, weight: .regular)
        textField.tag = EditType.introduce.rawValue
        return textField
    }()

    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()

    private var user: User

    init(user: User) {
        self.user = user
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureLayout() {
        super.configureLayout()

        [
            profileView, nameLabel, nameTextField, introduceLabel, introduceTextField
        ].forEach { addSubview($0) }

        profileView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(40)
            $0.width.height.equalTo(180)
            $0.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(20)
            $0.leadingMargin.equalToSuperview().inset(10)
            $0.width.equalTo(80)
        }

        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel)
            $0.leadingMargin.equalTo(nameLabel.snp.trailing).offset(10)
            $0.trailingMargin.equalToSuperview().inset(20)
        }

        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.leadingMargin.equalTo(nameLabel)
            $0.width.equalTo(nameLabel)
        }

        introduceTextField.snp.makeConstraints {
            $0.top.equalTo(introduceLabel)
            $0.leadingMargin.equalTo(introduceLabel.snp.trailing).offset(10)
            $0.trailingMargin.equalTo(nameTextField)
        }
    }

}
