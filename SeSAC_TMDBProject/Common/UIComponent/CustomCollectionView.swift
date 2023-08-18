//
//  CustomCollectionView.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import UIKit

final class CustomCollectionView: UICollectionView {

    private var reloadDataCompletionBlock: (() -> Void)?

    func reloadDataWithCompletion(_ complete: @escaping () -> Void) {
        reloadDataCompletionBlock = complete
        super.reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let block = reloadDataCompletionBlock {
            block()
        }
    }
}
