//
//  CustomCollectionView.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/17.
//

import UIKit

final class CustomCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }

}
