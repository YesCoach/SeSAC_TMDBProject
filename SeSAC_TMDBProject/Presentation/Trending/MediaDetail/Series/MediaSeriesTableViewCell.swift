//
//  MediaSeriesTableViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import UIKit

final class MediaSeriesTableViewCell: UITableViewCell {

    // MARK: - UIComponents

    @IBOutlet var collectionView: CustomCollectionView!

    // MARK: - Properties

    private var data: [Season] = [] {
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

extension MediaSeriesTableViewCell {

    func configure(with data: [Season]) {
        self.data = data
    }

}

// MARK: - Private Methods

private extension MediaSeriesTableViewCell {

    func configureUI() {
        configureCollectionViewLayout()
        collectionView.register(
            UINib(nibName: MediaSeriesCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: MediaSeriesCollectionViewCell.identifier
        )
        collectionView.register(
            UINib(nibName: MediaSeriesCollectionReusableView.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MediaSeriesCollectionReusableView.identifier
        )
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
    }

    func configureCollectionViewLayout() {
        let flowlayout = UICollectionViewFlowLayout()
        let spacing = 16.0
        let width = UIScreen.main.bounds.width
        flowlayout.itemSize = .init(width: width - (2 * spacing), height: 80.0)
        flowlayout.scrollDirection = .vertical
        flowlayout.headerReferenceSize = CGSize(width: width, height: 80.0)

        collectionView.collectionViewLayout = flowlayout
    }

}

// MARK: - UICollectionViewDataSource 구현부

extension MediaSeriesTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return data[section].episodes?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MediaSeriesCollectionViewCell.identifier,
            for: indexPath
        ) as? MediaSeriesCollectionViewCell
        else { return UICollectionViewCell() }

        guard let episode = data[indexPath.section].episodes?[indexPath.item]
        else { return UICollectionViewCell() }
        cell.configure(with: episode)

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: MediaSeriesCollectionReusableView.identifier,
                for: indexPath
            ) as? MediaSeriesCollectionReusableView
            else { return UICollectionReusableView() }
            view.configure(with: data[indexPath.section].name ?? "")

            return view
        } else {
            return UICollectionReusableView()
        }
    }

}
