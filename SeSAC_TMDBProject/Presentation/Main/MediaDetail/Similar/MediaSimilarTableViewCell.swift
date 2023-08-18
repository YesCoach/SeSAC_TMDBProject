//
//  MediaSimilarTableViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/18.
//

import UIKit

final class MediaSimilarTableViewCell: UITableViewCell {

    // MARK: - UIComponents

    @IBOutlet var collectionView: CustomCollectionView!

    // MARK: - Properties

    private var dataList: [Media] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

}

// MARK: - Methods

extension MediaSimilarTableViewCell {

    func configure(with dataList: [Media]) {
        self.dataList = dataList
    }

}

// MARK: - Private Methods

private extension MediaSimilarTableViewCell {

    func configureUI() {
        configureCollectionView()
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

        layout.itemSize = .init(width: width, height: width * 1.3)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = .init(top: spacing, left: spacing, bottom: spacing, right: spacing)

        collectionView.collectionViewLayout = layout
    }

}

// MARK: - UICollectionViewDataSource 구현부

extension MediaSimilarTableViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dataList.count
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

        let data = dataList[indexPath.row]
        cell.configure(with: data)

        return cell
    }

}
