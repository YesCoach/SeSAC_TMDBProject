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

    private var movieList: MovieList? {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
    }

}

// MARK: - UICollectionViewDataSource 구현부
extension MainViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return movieList?.results.count ?? 0
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

        guard let movieList else { return UICollectionViewCell() }
        let movie = movieList.results[indexPath.row]
        cell.configure(with: movie) { [weak self] movie in
            guard let self else { return }
            guard let viewController = storyboard?.instantiateViewController(
                identifier: MovieCastingViewController.identifier,
                creator: { coder in
                    let viewController = MovieCastingViewController(
                        movie: movie,
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

private extension MainViewController {

    func configureUI() {
        configureCollectionView()
        configureNavigationItem()
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

    func fetchData() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            NetworkManager.shared.callResponse(
                api: .trending(media: .movie, timeWindow: .week)
            ) { [self] (data: MovieList) in
                self.movieList = data
            }
        }
    }

}
