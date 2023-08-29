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

    private lazy var profileView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .systemMint
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "yescoach"
        label.font = .systemFont(ofSize: 13.0, weight: .bold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "smu ios dev 🍎"
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()

    override func configureLayout() {
        super.configureLayout()

        [
            profileView, nameLabel, descriptionLabel
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

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(nameLabel)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        profileView.layer.cornerRadius = profileView.frame.width / 2
    }
}
