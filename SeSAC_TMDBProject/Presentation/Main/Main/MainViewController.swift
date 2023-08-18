//
//  ViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var segmentControl: UISegmentedControl!

    private var mediaList: [Media] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private let mediaTypes = [APIURL.TMDB.MediaType.movie, .tv]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData(media: .movie)
    }

    @IBAction func didSegmentValueChanged(_ sender: UISegmentedControl) {
        fetchData(media: mediaTypes[sender.selectedSegmentIndex])
    }

}

// MARK: - UICollectionViewDataSource 구현부
extension MainViewController: UICollectionViewDataSource {

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
            withReuseIdentifier: MainCollectionViewCell.identifier,
            for: indexPath
        ) as? MainCollectionViewCell
        else { return UICollectionViewCell() }

        let media = mediaList[indexPath.row]

        if segmentControl.selectedSegmentIndex == 0 {
            cell.configure(with: media) { [weak self] media in
                guard let self else { return }
                guard let viewController = storyboard?.instantiateViewController(
                    identifier: MediaCastingViewController.identifier,
                    creator: { coder in
                        let viewController = MediaCastingViewController(
                            media: media,
                            coder: coder
                        )
                        return viewController
                    }
                ) else { return }
                navigationController?.pushViewController(viewController, animated: true)
            }
            return cell
        } else {
            cell.configure(with: media) { [weak self] media in
                guard let self else { return }
                guard let viewController = storyboard?.instantiateViewController(
                    identifier: MediaCastingViewController.identifier,
                    creator: { coder in
                        let viewController = MediaCastingViewController(
                            media: media,
                            coder: coder
                        )
                        return viewController
                    }
                ) else { return }
                navigationController?.pushViewController(viewController, animated: true)
            }
            return cell
        }
    }

}

private extension MainViewController {

    func configureUI() {
        configureCollectionView()
        configureNavigationItem()

        for item in mediaTypes.enumerated() {
            segmentControl.setTitle(item.element.description, forSegmentAt: item.offset)
        }
        segmentControl.sizeToFit()

    }

    func configureCollectionView() {
        let nib = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical

        let spacing = 0.0
        let width = UIScreen.main.bounds.width - (spacing * 2)

        layout.itemSize = .init(width: width , height: width * 1.2)

        collectionView.collectionViewLayout = layout
    }

    func configureNavigationItem() {
        leftBarButtonItem.image = .init(systemName: "list.bullet")
        rightBarButtonItem.image = .init(systemName: "magnifyingglass")
        navigationController?.navigationBar.tintColor = .systemMint
        navigationItem.backButtonTitle = ""
    }

    func fetchData(media: APIURL.TMDB.MediaType) {
        if media == .movie {
            NetworkManager.shared.callResponse(
                api: .trending(media: media, timeWindow: .week)
            ) { [self] (data: MovieResult) in
                self.mediaList = data.results
            }
        } else {
            NetworkManager.shared.callResponse(
                api: .trending(media: media, timeWindow: .week)
            ) { [self] (data: TVResult) in
                self.mediaList = data.results
            }
        }
    }

}
