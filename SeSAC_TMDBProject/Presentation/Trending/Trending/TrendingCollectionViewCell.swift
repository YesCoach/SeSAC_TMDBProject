//
//  TrendingCollectionViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import UIKit
import Kingfisher

final class TrendingCollectionViewCell: UICollectionViewCell {

    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var genreStackView: UIStackView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var scoreTitleLabel: PaddingLabel!
    @IBOutlet var scoreValueLabel: PaddingLabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var originalTitleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var chevronButton: UIButton!
    @IBOutlet var linkButton: UIButton!
    @IBOutlet var separatorView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var cardBackView: UIView!

    private var completionHandler: ((TrendingMedia)->())?
    private var media: TrendingMedia?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = .init(systemName: "photo.fill")
        scoreValueLabel.text = "0"
        titleLabel.text = "정보 없음"
        overviewLabel.text = nil
    }

    @IBAction func didChevronButtonTouched(_ sender: Any) {
        guard let completionHandler, let media
        else { return }
        completionHandler(media)
    }

    @objc func didCardViewTouched(_ sender: UITapGestureRecognizer) {
        guard let completionHandler, let media else { return }
        completionHandler(media)
    }

}

// MARK: - Methods

extension TrendingCollectionViewCell {

    func configure(with data: TrendingMedia, completion: @escaping (MediaContentsType) -> ()) {
        media = data

        if data.mediaType == .movie {
            releaseDateLabel.text = data.releaseDate
            titleLabel.text = "\(data.title ?? "제목 정보 없음")"
            if let originalTitle = data.originalTitle {
                originalTitleLabel.text = "\(originalTitle)"
            }
            if let genreIDs = data.genreIDs {
                let genreList = genreIDs.map { GenreList.movie[$0] }.compactMap { $0 }
                self.genreLabel.text = "#" + genreList.joined(separator: "#")
            }

        } else {
            releaseDateLabel.text = data.firstOnAirDate
            titleLabel.text = "\(data.name ?? "제목 정보 없음")"
            if let originalName = data.originalName {
                originalTitleLabel.text = "\(originalName)"
            }
            if let genreIDs = data.genreIDs {
                let genreList = genreIDs.map { GenreList.tv[$0] }.compactMap { $0 }
                self.genreLabel.text = "#" + genreList.joined(separator: "#")
            }
        }

        if let url = URL(string: data.posterURL) {
            posterImageView.kf.indicatorType = .activity
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                posterImageView.kf.setImage(with: url)
            }
        }

        if let voteAverage = data.voteAverage {
            scoreValueLabel.text = String(format: "%.1f", voteAverage)
        }

        overviewLabel.text = data.overview
        completionHandler = completion
    }
}

// MARK: - Private Methods

private extension TrendingCollectionViewCell {

    func configureUI() {
        releaseDateLabel.font = .systemFont(ofSize: 13.0, weight: .regular)
        releaseDateLabel.textColor = .systemGray
        genreLabel.font = .systemFont(ofSize: 14.0, weight: .bold)
        genreLabel.textColor = .black

        posterImageView.contentMode = .scaleAspectFill

        scoreTitleLabel.textColor = .white
        scoreTitleLabel.backgroundColor = .systemBlue
        scoreValueLabel.backgroundColor = .white

        titleLabel.font = .systemFont(ofSize: 17.0, weight: .regular)
        titleLabel.textColor = .black

        originalTitleLabel.font = .systemFont(ofSize: 15.0, weight: .regular)
        originalTitleLabel.textColor = .black

        overviewLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        overviewLabel.textColor = .systemGray
        detailLabel.font = .systemFont(ofSize: 13.0, weight: .regular)
        detailLabel.textColor = .black
        detailLabel.text = "자세히 보기"

        separatorView.backgroundColor = .systemGray
        linkButton.setImage(.init(systemName: "paperclip.circle.fill"), for: .normal)
        linkButton.tintColor = .white
        chevronButton.setImage(.init(systemName: "chevron.right"), for: .normal)
        chevronButton.tintColor = .systemGray

        cardBackView.layer.cornerRadius = 10.0
        cardBackView.layer.shadowColor = UIColor.black.cgColor
        cardBackView.layer.shadowOffset = .zero
        cardBackView.layer.shadowRadius = 10.0
        cardBackView.layer.shadowOpacity = 0.5
        cardBackView.clipsToBounds = false

        cardView.layer.cornerRadius = 10.0
        cardView.clipsToBounds = true

        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(didCardViewTouched))

        cardBackView.addGestureRecognizer(tapGestureRecognizer)
    }

}
