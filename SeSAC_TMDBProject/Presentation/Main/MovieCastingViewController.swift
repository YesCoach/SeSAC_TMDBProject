//
//  MovieCastingViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/13.
//

import UIKit

final class MovieCastingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    // MARK: - HeaderView
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var backgroundImageView: UIImageView!

    private let movie: Movie
    private var castingList: [Cast] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    init?(movie: Movie, coder: NSCoder) {
        self.movie = movie
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
    }

}

extension MovieCastingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return castingList.count
        default: return 0
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieCastingTableViewCell.identifier,
            for: indexPath
        ) as? MovieCastingTableViewCell
        else { return UITableViewCell() }

        switch indexPath.section {
        case 0: return cell
        case 1:
            let cast = castingList[indexPath.row]

            cell.configure(with: cast)

            return cell
        default: return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "OverView"
        case 1: return "Cast"
        default: return ""
        }
    }
}

private extension MovieCastingViewController {

    func configureUI() {
        configureTableView()

        titleLabel.text = movie.title
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white

        thumbnailView.contentMode = .scaleAspectFill
        backgroundImageView.contentMode = .scaleAspectFill

        if let url = URL(string: movie.posterURL) {
            thumbnailView.kf.indicatorType = .activity
            thumbnailView.kf.setImage(with: url)
        }
        if let backdropURL = movie.backdropURL,
           let url = URL(string: backdropURL) {
            backgroundImageView.kf.indicatorType = .activity
            backgroundImageView.kf.setImage(with: url)
        }
    }

    func configureTableView() {
        let nib = UINib(nibName: MovieCastingTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieCastingTableViewCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = 80.0
    }

    func fetchData() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            NetworkManager.shared.callResponse(
                api: .credit(movieID: movie.id)
            ) { [self] (data: MovieCredit) in
                self.castingList = data.cast
            }
        }
    }

}
