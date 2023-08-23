//
//  MapViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/24.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    // MARK: - UIComponents

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Private Methods

private extension MapViewController {
    func configureUI() {
        configureLayout()
        configureMapView()
    }

    func configureLayout() {
        view.addSubview(mapView)

        [
            mapView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach {
            $0.isActive = true
        }
    }

    func configureMapView() {
        if let coordinate = LocationManager.shared.currenCoordinate {
            let region = MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: 300,
                longitudinalMeters: 300
            )
            mapView.setRegion(region, animated: true)
        }
    }
}

// MARK: - MKMapViewDelegate 구현부

extension MapViewController: MKMapViewDelegate {

}
