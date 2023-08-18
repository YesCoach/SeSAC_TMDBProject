//
//  MediaSeriesCollectionViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import UIKit

final class MediaSeriesCollectionViewCell: UICollectionViewCell {

    // MARK: - UIComponents

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var episodeTitleLabel: UILabel!
    @IBOutlet var episodeRuntimeLabel: UILabel!
    @IBOutlet var episodeOverviewLabel: UILabel!

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

}

// MARK: - Methods

extension MediaSeriesCollectionViewCell {

    func configure(with data: Episode) {
        if let imageURL = data.imageURL {
            thumbnailImageView.kf.setImage(with: URL(string: imageURL))
        }
        episodeTitleLabel.text = data.name
        episodeRuntimeLabel.text = "\(data.runtime)"
        episodeOverviewLabel.text = data.overview
    }

}

// MARK: - Privaet Methods

private extension MediaSeriesCollectionViewCell {

    func configureUI() {
        thumbnailImageView.contentMode = .scaleAspectFill
        episodeTitleLabel.font = .systemFont(ofSize: 17.0, weight: .regular)
        episodeRuntimeLabel.font = .systemFont(ofSize: 13.0, weight: .regular)
        episodeRuntimeLabel.textColor = .gray

        episodeOverviewLabel.numberOfLines = 0
        episodeOverviewLabel.font = .systemFont(ofSize: 15.0, weight: .regular)
    }

}
