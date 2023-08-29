//
//  BaseView.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() { }

    func configureLayout() { }

}
