//
//  MainCollectionViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import UIKit
import Kingfisher

final class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var genreStackView: UIStackView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var scoreTitleLabel: PaddingLabel!
    @IBOutlet var scoreValueLabel: PaddingLabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var castingLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var chevronButton: UIButton!
    @IBOutlet var linkButton: UIButton!
    @IBOutlet var separatorView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var cardBackView: UIView!

    private var completionHandler: ((Media)->())?
    private var media: Media?

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
        castingLabel.text = nil
    }

    @IBAction func didChevronButtonTouched(_ sender: Any) {
        guard let completionHandler, let media
        else { return }
        completionHandler(media)
    }

    @objc func didCardViewTouched(_ sender: UITapGestureRecognizer) {
        guard let completionHandler, let media
        else { return }
        completionHandler(media)
    }

}

// MARK: - Methods

extension MainCollectionViewCell {

    func configure(with data: Media, completion: @escaping (Media) -> ()) {
        media = data

        releaseDateLabel.text = data.releaseDate

        var genre: [String] = []

        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            NetworkManager.shared.callResponse(
                api: .genre(media: .movie)
            ) { [self] (genreList: GenreList) in
                genre = genreList.genres
                    .filter { data.genreIDs.contains($0.id) }
                    .map { $0.name }

                self.genreLabel.text = "#" + genre.joined(separator: "#")
            }
        }

        if let url = URL(string: data.posterURL) {
            posterImageView.kf.indicatorType = .activity
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                posterImageView.kf.setImage(with: url)
            }
        }

        scoreValueLabel.text = String(format: "%.1f", data.voteAverage)
        titleLabel.text = "\(data.title)"
        castingLabel.text = "으아아아"

        completionHandler = completion
    }
}

// MARK: - Private Methods

private extension MainCollectionViewCell {

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
