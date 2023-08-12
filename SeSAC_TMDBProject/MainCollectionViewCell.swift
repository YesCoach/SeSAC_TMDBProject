//
//  MainCollectionViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var scoreTitleLabel: UILabel!
    @IBOutlet var scoreValueLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var castingLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var chevronButton: UIButton!
    @IBOutlet var linkButton: UIButton!
    @IBOutlet var separatorView: UIView!
    @IBOutlet var CardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }
}

private extension MainCollectionViewCell {

    func configureUI() {
        releaseDateLabel.font = .systemFont(ofSize: 13.0, weight: .regular)
        releaseDateLabel.textColor = .systemGray
        genreLabel.font = .systemFont(ofSize: 14.0, weight: .bold)
        genreLabel.textColor = .black

        titleLabel.font = .systemFont(ofSize: 17.0, weight: .regular)
        titleLabel.textColor = .black
        castingLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        castingLabel.textColor = .systemGray
        detailLabel.font = .systemFont(ofSize: 13.0, weight: .regular)
        detailLabel.textColor = .black
        detailLabel.text = "자세히 보기"

        separatorView.backgroundColor = .systemGray
        linkButton.setImage(.init(systemName: "paperclip.circle.fill"), for: .normal)
        linkButton.tintColor = .white
        chevronButton.setImage(.init(systemName: "chevron.right"), for: .normal)
        chevronButton.tintColor = .systemGray
    }

}

extension MainCollectionViewCell {

    func configure(with data: Movie) {
        releaseDateLabel.text = data.releaseDate
        genreLabel.text = "\(data.genreIDs?.first)"
    }
}
