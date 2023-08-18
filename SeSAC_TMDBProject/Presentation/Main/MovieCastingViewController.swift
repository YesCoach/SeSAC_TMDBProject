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

    private let media: Media
    private let dispatchGroup = DispatchGroup()

    private var seasonArray: [Season] = []
    private var seasonList: [TVDetail.Season] = [] {
        didSet {
            seasonList.forEach {
                dispatchGroup.enter()
                NetworkManager.shared.callResponse(
                    api: .seasonsDetails(seriesID: media.id, seasonNumber: $0.seasonNumber)
                ) { [weak self] (data: Season) in
                    guard let self else { return }
                    seasonArray.append(data)
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .global()) { [weak self] in
                guard let self else { return }
                seasonArray = seasonArray.sorted { $0.id < $1.id }
                DispatchQueue.main.async { [self] in
                    self.tableView.reloadData()
                }
            }
        }
    }

    private var castingList: [Cast] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    init?(media: Media, coder: NSCoder) {
        self.media = media
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
        return media.mediaType == .tv ? 3 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return media.mediaType == .tv ? 1 : castingList.count
        case 2: return castingList.count
        default: return 0
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieOverviewTableViewCell.identifier,
                for: indexPath
            ) as? MovieOverviewTableViewCell
            else { return UITableViewCell() }

            cell.configure(with: media.overview) {
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }

            return cell
        case 1:
            if media.mediaType == .tv {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: MediaSeriesTableViewCell.identifier,
                    for: indexPath
                ) as? MediaSeriesTableViewCell
                else { return UITableViewCell() }

                cell.configure(with: seasonArray) {
                    tableView.layoutIfNeeded()
                }

                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: MovieCastingTableViewCell.identifier,
                    for: indexPath
                ) as? MovieCastingTableViewCell
                else { return UITableViewCell() }

                let cast = castingList[indexPath.row]
                cell.configure(with: cast)

                return cell
            }
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieCastingTableViewCell.identifier,
                for: indexPath
            ) as? MovieCastingTableViewCell
            else { return UITableViewCell() }

            let cast = castingList[indexPath.row]
            cell.configure(with: cast)

            return cell
        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "OverView"
        case 1: return media.mediaType == .movie ? "Cast" : "Series"
        case 2: return "Cast"
        default: return ""
        }
    }

}

private extension MovieCastingViewController {

    func configureUI() {
        configureTableView()
        configureNavigationItem()

        titleLabel.text = media.title
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white

        thumbnailView.contentMode = .scaleAspectFill
        backgroundImageView.contentMode = .scaleAspectFill

        if let url = URL(string: media.posterURL) {
            thumbnailView.kf.indicatorType = .activity
            thumbnailView.kf.setImage(with: url)
        }
        if let url = URL(string: media.backdropURL) {
            backgroundImageView.kf.indicatorType = .activity
            backgroundImageView.kf.setImage(with: url)
        }
    }

    func configureTableView() {
        tableView.register(
            UINib(nibName: MovieCastingTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MovieCastingTableViewCell.identifier
        )
        tableView.register(
            UINib(nibName: MovieOverviewTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MovieOverviewTableViewCell.identifier
        )
        tableView.register(
            UINib(nibName: MediaSeriesTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MediaSeriesTableViewCell.identifier
        )
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }

    func configureNavigationItem() {
        navigationItem.title = "출연/제작"
    }

    func fetchData() {

        if media.mediaType == .movie {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                NetworkManager.shared.callResponse(
                    api: .movieCredit(movieID: media.id)
                ) { [self] (data: MovieCredit) in
                    self.castingList = data.cast
                }
            }
        }

        if media.mediaType == .tv {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                NetworkManager.shared.callResponse(
                    api: .tvCredit(seriesID: media.id)
                ) { [self] (data: MovieCredit) in
                    self.castingList = data.cast
                }
            }

            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                NetworkManager.shared.callResponse(
                    api: .tvDetail(seriesID: media.id)
                ) { [self] (data: TVDetail) in
                    self.seasonList = data.seasons
                }
            }
        }
    }

}
