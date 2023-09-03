//
//  TrendingViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import UIKit
import SnapKit

final class TrendingViewController: UIViewController {

    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.image = .init(systemName: "list.bullet")
        return barButtonItem
    }()

    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.image = .init(systemName: "magnifyingglass")
        return barButtonItem
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.register(
            UINib(nibName: TrendingCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier
        )
        collectionView.register(
            UINib(nibName: TrendingPersonCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: TrendingPersonCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        return collectionView
    }()

    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.addTarget(
            self,
            action: #selector(didSegmentValueChanged),
            for: .valueChanged
        )
        for item in mediaTypes.enumerated() {
            segmentControl.insertSegment(
                withTitle: item.element.description, at: item.offset, animated: true
            )
        }
        segmentControl.selectedSegmentIndex = 0
        segmentControl.sizeToFit()
        return segmentControl
    }()

    private var mediaList: [TrendingMedia] = [] {
        didSet {
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.reloadData()
        }
    }

    private let mediaTypes = APIURL.TMDB.MediaType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.checkDeviceLocationAuthorization()
        configureUI()
        fetchData(media: .movie)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }

    @objc func didSegmentValueChanged(_ sender: UISegmentedControl) {
        fetchData(media: mediaTypes[sender.selectedSegmentIndex])
    }

}

// MARK: - UICollectionViewDataSource 구현부
extension TrendingViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return mediaList.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let media = mediaList[indexPath.row]
        if media.mediaType == .person {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendingPersonCollectionViewCell.identifier,
                for: indexPath
            ) as? TrendingPersonCollectionViewCell
            else { return UICollectionViewCell() }

            guard let person = media.getConcreteModel() as? Person
            else { return UICollectionViewCell() }
            cell.configure(with: person)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendingCollectionViewCell.identifier,
                for: indexPath
            ) as? TrendingCollectionViewCell
            else { return UICollectionViewCell() }

            cell.configure(with: media) { [weak self] media in
                guard let self else { return }
                let viewController = MediaCastingViewController(media: media)
                navigationController?.pushViewController(viewController, animated: true)
            }
            return cell
        }
    }

}

private extension TrendingViewController {

    func configureUI() {
        configureNavigationItem()
        configureLayout()
        configureTabBarItem()
        createCollectionViewLayout()
        view.backgroundColor = .systemBackground
    }

    func configureNavigationItem() {
        navigationController?.navigationBar.tintColor = .systemMint
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.titleView = segmentControl
    }

    func configureTabBarItem() {
        tabBarItem.title = "트렌드"
        tabBarItem.image = .init(systemName: "chart.line.uptrend.xyaxis.circle")
    }

    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: {(
                sectionIndex: Int,
                layoutEnvironment: NSCollectionLayoutEnvironment
            ) -> NSCollectionLayoutSection? in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(100)
                )
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(100)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: 1
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

                return section
            }
        )

        return layout
    }

    func configureLayout() {
        [
            collectionView
        ].forEach {
            view.addSubview($0)
        }

        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func fetchData(media: APIURL.TMDB.MediaType) {
        NetworkManager.shared.callResponse(
            api: .trending(media: media, timeWindow: .week)
        ) { [weak self] (data: NetworkResponseData<TrendingMedia>) in
            guard let self else { return }
            self.mediaList = data.results
        }
    }
}
