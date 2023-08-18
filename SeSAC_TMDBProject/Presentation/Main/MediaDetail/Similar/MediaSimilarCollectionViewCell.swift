//
//  MediaSimilarCollectionViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/18.
//

import UIKit
import Kingfisher

final class MediaSimilarCollectionViewCell: UICollectionViewCell {

    // MARK: - UIComponents

    @IBOutlet var posterImageView: UIImageView!

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = .init(systemName: "questionmark")
    }

}

// MARK: - Methods

extension MediaSimilarCollectionViewCell {

    func configure(with data: Media) {
        if let url = URL(string: data.posterURL) {
            posterImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "questionmark")
            )
        }
    }

}

// MARK: - Private Methods

private extension MediaSimilarCollectionViewCell {

    func configureUI() {
        posterImageView.contentMode = .scaleAspectFill
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
    }

}
