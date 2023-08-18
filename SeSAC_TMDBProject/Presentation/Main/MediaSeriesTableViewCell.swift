//
//  MediaSeriesTableViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import UIKit

final class MediaSeriesTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: CustomCollectionView!

    private var data: [Season] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    var completionHandler: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()

        configureUI()
    }
}

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

        collectionView.reloadDataWithCompletion { [weak self] in
            guard let self, let completionHandler else { return }
            self.layoutIfNeeded()
            completionHandler()
        }
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

extension MediaSeriesTableViewCell {

    func configure(with data: [Season], completion: @escaping () -> ()) {
        self.data = data
        self.completionHandler = completion
    }

}

extension MediaSeriesTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].episodes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
