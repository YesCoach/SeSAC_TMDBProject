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
    @IBOutlet var collectionView: UICollectionView!

    private var person: Person?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = .init(systemName: "photo")
        nameLabel.text = "이름 정보없음"
        departmentLabel.text = "파트 정보없음"
        genderLabel.text = "성별 정보없음"
    }
}

// MARK: - Methods

extension TrendingPersonCollectionViewCell {

    func configure(with data: Person) {
        self.person = data
        nameLabel.text = data.name
        departmentLabel.text = data.knownForDepartment
        if let gender = data.gender,
           let description = Gender(rawValue: gender)?.description {
            genderLabel.text = description
        }
        if let imageURL = URL(string: data.profileURL) {
            profileImageView.kf.setImage(with: imageURL)
            profileImageView.kf.indicatorType = .activity
        }
        collectionView.reloadData()
    }
}

extension TrendingPersonCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person?.knownFor?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MediaSimilarCollectionViewCell.identifier,
            for: indexPath
        ) as? MediaSimilarCollectionViewCell
        else { return UICollectionViewCell() }

        guard let data = person?.knownFor else { return UICollectionViewCell() }
        cell.configure(with: data[indexPath.item].posterURL)

        return cell
    }
}

// MARK: - Private Methods

private extension TrendingPersonCollectionViewCell {

    func configureUI() {
        configureCollectionView()
        profileImageView.layer.cornerRadius = 20.0
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .lightGray

        nameLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        departmentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        genderLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
    }

    func configureCollectionView() {
        configureCollectionViewLayout()
        collectionView.register(
            UINib(nibName: MediaSimilarCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: MediaSimilarCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
    }

    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let spacing = 20.0
        let width = (UIScreen.main.bounds.width - (spacing * 3)) / 3

        layout.itemSize = .init(width: width, height: width * 1.4)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = .init(top: spacing, left: spacing, bottom: spacing, right: spacing)

        collectionView.collectionViewLayout = layout
    }
}
