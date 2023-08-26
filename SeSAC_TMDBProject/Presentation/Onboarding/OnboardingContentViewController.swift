//
//  OnboardingContentViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/26.
//

import UIKit

final class OnboardingContentViewController: UIViewController {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
}

extension OnboardingContentViewController {

    func configure(with text: String, backgroundColor: UIColor) {
        label.text = text
        imageView.backgroundColor = backgroundColor
    }
}

private extension OnboardingContentViewController {

    func configureUI() {
        view.addSubview(imageView)
        view.addSubview(label)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        [
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            label.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
        ].forEach { $0.isActive = true }
    }
}
