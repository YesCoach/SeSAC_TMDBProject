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
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical

        let spacing = 0.0
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = .init(width: width , height: width * 1.2)

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        let nib = UINib(nibName: TrendingCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
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
            collectionView.reloadData()
        }
    }

    private let mediaTypes = [APIURL.TMDB.MediaType.movie, .tv]

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.checkDeviceLocationAuthorization()
        configureUI()
        fetchData(media: .movie)
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
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrendingCollectionViewCell.identifier,
            for: indexPath
        ) as? TrendingCollectionViewCell
        else { return UICollectionViewCell() }

        let media = mediaList[indexPath.row]
        let data = media.getConcreteModel()
        cell.configure(with: data) { [weak self] media in
            guard let self else { return }
            let viewController = MediaCastingViewController(media: media)
            navigationController?.pushViewController(viewController, animated: true)
        }
        return cell
    }

}

private extension TrendingViewController {

    func configureUI() {
        configureNavigationItem()
        configureLayout()
        configureTabBarItem()
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
