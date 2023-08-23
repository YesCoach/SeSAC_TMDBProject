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

    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.setImage(UIImage(systemName: "location.circle"), for: .normal)
        button.tintColor = .systemMint
        button.addTarget(self, action: #selector(didLocationButtonTouched), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.delegate = self
        configureUI()
    }

    @objc func didLocationButtonTouched(_ sender: UIButton) {
        LocationManager.shared.checkDeviceLocationAuthorization()
    }
}

// MARK: - Private Methods

private extension MapViewController {
    func configureUI() {
        configureLayout()
        configureMapView()
    }

    func configureLayout() {
        [
            mapView, locationButton
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            locationButton.widthAnchor.constraint(equalToConstant: 50),
            locationButton.heightAnchor.constraint(equalTo: locationButton.widthAnchor),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            )
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

// MARK: - LocationManagerDelegate 구현부

extension MapViewController: LocationManagerDelegate {
    func presentAuthorizationAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
}
