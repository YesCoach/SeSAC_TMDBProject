//
//  MediaCastingHeaderView.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/09/01.
//

import UIKit

final class MediaCastingHeaderView: UIView {

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = media.title
        view.font = .systemFont(ofSize: 28, weight: .bold)
        view.textColor = .white
        return view
    }()

    private lazy var thumbnailView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        if let url = URL(string: media.posterURL) {
            view.kf.indicatorType = .activity
            view.kf.setImage(with: url)
        }
        return view
    }()

    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        if let url = URL(string: media.backdropURL) {
            view.kf.indicatorType = .activity
            view.kf.setImage(with: url)
        }
        return view
    }()

    private let media: MediaContentsType

    init(media: MediaContentsType) {
        self.media = media
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension MediaCastingHeaderView {

    func configureUI() {
        configureLayout()
    }

    func configureLayout() {
        [
            backgroundImageView, titleLabel, thumbnailView
        ].forEach { addSubview($0) }

        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.horizontalEdges.equalTo(self).inset(30)
            $0.bottom.lessThanOrEqualTo(thumbnailView.snp.top).inset(10)
        }
        thumbnailView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel).offset(5)
            $0.bottom.equalTo(self).inset(10)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
//            $0.width.equalTo(thumbnailView.snp.height).multipliedBy(2/3)
        }
    }
}
