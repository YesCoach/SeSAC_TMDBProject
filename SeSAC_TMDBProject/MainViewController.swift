//
//  ViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/11.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        // Do any additional setup after loading the view.

        NetworkManager.shared.callResponse(api: .trending(media: .movie, timeWindow: .week)) { (data: MovieList) in
            print(data)
        }
    }

}

private extension MainViewController {

    func configureNavigationItem() {
        leftBarButtonItem.image = .init(systemName: "list.bullet")
        rightBarButtonItem.image = .init(systemName: "magnifyingglass")
    }

}
