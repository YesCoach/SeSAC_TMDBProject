//
//  MediaOverviewTableViewCell.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/14.
//

import UIKit

final class MediaOverviewTableViewCell: UITableViewCell {

    // MARK: - UIComponents

    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var expandButton: UIButton!

    // MARK: - Properties

    var completionHandler: (() -> ())?

    // MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    // MARK: - IBActions

    @IBAction func didExpandButtonTouched(_ sender: UIButton) {
        sender.isSelected.toggle()
        overviewLabel.numberOfLines = sender.isSelected ? 0 : 2
        completionHandler?()
    }

}

// MARK: - Methods

extension MediaOverviewTableViewCell {

    func configure(with overview: String?, completion: @escaping (() -> ())) {
        overviewLabel.text = overview
        completionHandler = completion
        selectionStyle = .none
    }

}

// MARK: - Private Methods

private extension MediaOverviewTableViewCell {

    func configureUI() {
        expandButton.setImage(.init(systemName: "chevron.down"), for: .normal)
        expandButton.setImage(.init(systemName: "chevron.up"), for: .selected)
        expandButton.tintColor = .gray
        expandButton.adjustsImageWhenHighlighted = false
    }

}
