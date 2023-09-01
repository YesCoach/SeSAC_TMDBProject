//
//  TrendingPersonCollectionViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/09/01.
//

import UIKit

final class TrendingPersonCollectionViewCell: UICollectionViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var departmentLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var mediaCollectionView: UICollectionView!

    private var person: Person?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = .init(systemName: "photo.fill")
        nameLabel.text = "이름 정보없음"
        departmentLabel.text = "파트 정보없음"
        genderLabel.text = "성별 정보없음"
    }
}

// MARK: - Methods

extension TrendingPersonCollectionViewCell {

    func configure(with data: Person) {
        nameLabel.text = data.name
        departmentLabel.text = data.knownForDepartment
        if let gender = data.gender,
           let description = Gender(rawValue: gender)?.description {
            genderLabel.text = description
        }
        if let url = data.profilePath,
           let imageURL = URL(string: url) {
            profileImageView.kf.setImage(with: imageURL, placeholder: UIImage(systemName: "photo.fill"))
            profileImageView.kf.indicatorType = .activity
        }
    }
}

// MARK: - Private Methods

private extension TrendingPersonCollectionViewCell {

    func configureUI() {
        profileImageView.layer.cornerRadius = 20.0
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .lightGray

        nameLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        departmentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        genderLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
    }

}
