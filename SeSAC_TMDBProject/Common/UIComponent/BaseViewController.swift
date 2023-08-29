//
//  BaseViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
    }

    func configureView() {
        view.backgroundColor = .systemBackground
    }

    func configureLayout() { }

}
