//
//  MediaSeriesCollectionReusableView.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import UIKit

final class MediaSeriesCollectionReusableView: UICollectionReusableView {

    @IBOutlet var seriesTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
}

private extension MediaSeriesCollectionReusableView {

    func configureUI() {
        seriesTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
    }

}

extension MediaSeriesCollectionReusableView {

    func configure(with title: String) {
        seriesTitleLabel.text = title
    }

}

