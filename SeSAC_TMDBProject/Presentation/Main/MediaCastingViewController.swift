//
//  MediaCastingViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/13.
//

import UIKit

final class MediaCastingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    // MARK: - HeaderView
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var backgroundImageView: UIImageView!

    private let media: Media

    private var seasonArray: [Season] = []
    private var seasonList: [TVDetail.Season] = [] {
        didSet {
            let group = DispatchGroup()
            seasonList.forEach {
                group.enter()
                NetworkManager.shared.callResponse(
                    api: .seasonsDetails(seriesID: media.id, seasonNumber: $0.seasonNumber)
                ) { [weak self] (data: Season) in
                    guard let self else { return }
                    seasonArray.append(data)
                    group.leave()
                }
            }
            group.notify(queue: .global()) { [weak self] in
                guard let self else { return }
                seasonArray = seasonArray.sorted { $0.id < $1.id }
                DispatchQueue.main.async { [self] in
                    self.tableView.reloadData()
                }
            }
        }
    }

    private var castingList: [Cast] = []

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

extension MediaCastingViewController: UITableViewDataSource {

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
                withIdentifier: MediaOverviewTableViewCell.identifier,
                for: indexPath
            ) as? MediaOverviewTableViewCell
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
                    withIdentifier: MediaCastingTableViewCell.identifier,
                    for: indexPath
                ) as? MediaCastingTableViewCell
                else { return UITableViewCell() }

                let cast = castingList[indexPath.row]
                cell.configure(with: cast)

                return cell
            }
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MediaCastingTableViewCell.identifier,
                for: indexPath
            ) as? MediaCastingTableViewCell
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

private extension MediaCastingViewController {

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
            UINib(nibName: MediaCastingTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MediaCastingTableViewCell.identifier
        )
        tableView.register(
            UINib(nibName: MediaOverviewTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MediaOverviewTableViewCell.identifier
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
            NetworkManager.shared.callResponse(
                api: .movieCredit(movieID: media.id)
            ) { [self] (data: MovieCredit) in
                self.castingList = data.cast
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    tableView.reloadData()
                }
            }
        }

        if media.mediaType == .tv {
            let group = DispatchGroup()

            group.enter()
            NetworkManager.shared.callResponse(
                api: .tvCredit(seriesID: media.id)
            ) { [self] (data: MovieCredit) in
                self.castingList = data.cast
                group.leave()
            }
            group.enter()
            NetworkManager.shared.callResponse(
                api: .tvDetail(seriesID: media.id)
            ) { [self] (data: TVDetail) in
                self.seasonList = data.seasons
                group.leave()
            }

            group.notify(queue: .main) { [weak self] in
                guard let self else { return }
                tableView.reloadData()
            }
        }
    }

}
