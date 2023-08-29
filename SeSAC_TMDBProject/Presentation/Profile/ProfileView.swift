//
//  ProfileView.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

final class ProfileView: BaseView {

    /*
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "yescoach_dev_"
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        return label
    }()
     */

    // MARK: - UIComponents

    private lazy var profileView: UIImageView = {
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
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = user.name
        label.font = .systemFont(ofSize: 13.0, weight: .bold)
        return label
    }()

    private lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.text = user.introduce
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()

    // MARK: - Properties

    private var user: User {
        didSet {
            if let profileImageURL = user.profileImageURL,
               let url = URL(string: profileImageURL)
            {
                profileView.kf.setImage(with: url)
            } else {
                profileView.image = .init(systemName: "person.circle.fill")
            }

            nameLabel.text = user.name
            introduceLabel.text = user.introduce
        }
    }

    // MARK: - Initializer

    init(user: User) {
        self.user = user
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func configureLayout() {
        super.configureLayout()

        [
            profileView, nameLabel, introduceLabel
        ].forEach { addSubview($0) }

        profileView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(80)
            $0.width.height.equalTo(180)
            $0.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(80)
        }

        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(nameLabel)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        profileView.layer.cornerRadius = profileView.frame.width / 2
    }
}

extension ProfileView {

    func configure(with user: User) {
        self.user = user
    }
}
