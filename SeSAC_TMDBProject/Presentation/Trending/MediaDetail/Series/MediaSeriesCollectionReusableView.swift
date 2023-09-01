//
//  MediaSeriesCollectionReusableView.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import UIKit

final class MediaSeriesCollectionReusableView: UICollectionReusableView {

    // MARK: - UIComponents

    @IBOutlet var seriesTitleLabel: UILabel!

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
}

// MARK: - Methods

extension MediaSeriesCollectionReusableView {

    func configure(with title: String) {
        seriesTitleLabel.text = title
    }

}

// MARK: - Private Methods

private extension MediaSeriesCollectionReusableView {

    func configureUI() {
        seriesTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
    }

}
