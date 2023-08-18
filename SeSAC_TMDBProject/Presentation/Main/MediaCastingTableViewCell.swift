//
//  MediaCastingTableViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/13.
//

import UIKit

class MediaCastingTableViewCell: UITableViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var castingNameLabel: UILabel!
    @IBOutlet var castingInfoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = .init(systemName: "person.fill")
        castingNameLabel.text = "정보 없음"
        castingInfoLabel.text = "정보 없음"
    }

}

extension MediaCastingTableViewCell {

    func configure(with data: Cast) {
        castingNameLabel.text = data.castName
        castingInfoLabel.text = "\(data.characterName)"

        if let imageURL = data.imageURL,
           let url = URL(string: imageURL) {
            thumbnailImageView.kf.setImage(with: url)
        } else {
            thumbnailImageView.image = .init(systemName: "person.fill")
        }
    }

}

private extension MediaCastingTableViewCell {

    func configureUI() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 5.0
        thumbnailImageView.tintColor = .black

        castingNameLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        castingNameLabel.textColor = .black

        castingInfoLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        castingInfoLabel.textColor = .lightGray
    }
}
