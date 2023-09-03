//
//  MediaCastingViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/13.
//

import UIKit

final class MediaCastingViewController: UIViewController {

    // MARK: - UIComponents

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(
            UINib(nibName: MediaCastingTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MediaCastingTableViewCell.identifier
        )
        view.register(
            UINib(nibName: MediaOverviewTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MediaOverviewTableViewCell.identifier
        )
        view.register(
            UINib(nibName: MediaSeriesTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MediaSeriesTableViewCell.identifier
        )
        view.register(
            UINib(nibName: MediaSimilarTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: MediaSimilarTableViewCell.identifier
        )
        view.dataSource = self
        view.delegate = self
        view.tableHeaderView = headerView
        view.tableHeaderView?.frame = .init(x: 0, y: 0, width: view.frame.width, height: 300)
        return view
    }()

    // MARK: HeaderView

    private lazy var headerView: MediaCastingHeaderView = {
        let view = MediaCastingHeaderView(media: media)
        return view
    }()

    // MARK: - Properties

    private let media: TrendingMedia
    private var similarArray: [MediaContentsType] = []
    private var seasonArray: [Season] = []
    private var castingList: [Cast] = []

    // MARK: - Initializer

    init(media: TrendingMedia) {
        self.media = media
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
    }

}

// MARK: - Private Methods

private extension MediaCastingViewController {

    // MARK: UI

    func configureUI() {
        configureNavigationItem()
        configureLayout()
        view.backgroundColor = .systemBackground
    }

    func configureNavigationItem() {
        navigationItem.title = "출연/제작"
    }

    func configureLayout() {
        [
            tableView
        ].forEach { view.addSubview($0) }

        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Logic

    func fetchData() {
        let group = DispatchGroup()

        switch media.mediaType {
        case .movie:
            group.enter()
            NetworkManager.shared.callResponse(
                api: .movieCredit(movieID: media.id)
            ) { [weak self] (data: MovieCredit) in
                guard let self else { return }
                castingList = data.cast
                group.leave()
            }

            group.enter()
            NetworkManager.shared.callResponse(
                api: .movieSimilar(movieID: media.id)
            ) { [weak self] (data: NetworkResponseData<Movie>) in
                guard let self else { return }
                similarArray = data.results.filter { $0.posterPath != nil }
                group.leave()
            }
        case .tv:
            group.enter()
            NetworkManager.shared.callResponse(
                api: .tvCredit(seriesID: media.id)
            ) { [weak self] (data: MovieCredit) in
                guard let self else { return }
                castingList = data.cast
                group.leave()
            }

            group.enter()
            NetworkManager.shared.callResponse(
                api: .tvSimilar(seriesID: media.id)
            ) { [weak self] (data: NetworkResponseData<TV>) in
                guard let self else { return }
                similarArray = data.results
                group.leave()
            }

            group.enter()
            NetworkManager.shared.callResponse(
                api: .tvDetail(seriesID: media.id)
            ) { [weak self] (data: TVDetail) in
                guard let self else { return }
                let nestedGroup = DispatchGroup()

                data.seasons.forEach { [self] in
                    nestedGroup.enter()
                    NetworkManager.shared.callResponse(
                        api: .seasonsDetails(
                            seriesID: self.media.id,
                            seasonNumber: $0.seasonNumber
                        )
                    ) { (data: Season) in
                        self.seasonArray.append(data)
                        nestedGroup.leave()
                    }
                }

                nestedGroup.notify(queue: .global()) {
                    self.seasonArray = self.seasonArray.sorted { $0.id < $1.id }
                    group.leave()
                }
            }
        default: return
        }

        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource rngusqn

extension MediaCastingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        switch media.mediaType {
        case .movie: return 3
        case .tv: return 4
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return media.mediaType == .tv ? 1 : castingList.count
        case 3: return castingList.count
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
                withIdentifier: MediaSimilarTableViewCell.identifier,
                for: indexPath
            ) as? MediaSimilarTableViewCell
            else { return UITableViewCell() }

            cell.configure(with: similarArray)

            return cell
        case 1:
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
        case 2:
            if media.mediaType == .tv {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: MediaSeriesTableViewCell.identifier,
                    for: indexPath
                ) as? MediaSeriesTableViewCell
                else { return UITableViewCell() }

                cell.configure(with: seasonArray)

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
        case 3:
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
        case 0: return "Similar"
        case 1: return "OverView"
        case 2: return media.mediaType == .movie ? "Cast" : "Series"
        case 3: return "Cast"
        default: return ""
        }
    }

}

// MARK: - UITableViewDelegate 구현부

extension MediaCastingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180.0
        }

        return UITableView.automaticDimension
    }

}
