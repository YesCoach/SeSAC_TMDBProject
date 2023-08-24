//
//  MapViewController.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/24.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    typealias Coordinate = (Double, Double)

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

    // MARK: - Properties

    private let cgvList = [
        ((37.557908, 126.925766), "CGV 연남"),
        ((37.530161, 126.965179), "CGV 용산아이파크몰"),
        ((37.563463, 126.982927), "CGV 명동"),
        ((37.571073, 126.991204), "CGV 피카디리1958"),
        ((37.568796, 127.007675), "CGV 을지로"),
        ((37.583461, 126.999842), "CGV 대학로"),
        ((37.524357, 127.029423), "CGV 압구정신관"),
        ((37.501670, 127.026383), "CGV 강남")
    ]
    private let lotteList = [
        ((37.564191, 126.981633), "롯데시네마 을지로"),
        ((37.532800, 126.959707), "롯데시네마 용산"),
        ((37.557297, 126.925099), "롯데시네마 홍대입구"),
        ((37.551270, 126.913434), "롯데시네마 합정"),
        ((37.516190, 126.908323), "롯데시네마 영등포"),
        ((37.516608, 127.021758), "롯데시네마 신사"),
        ((37.487417, 127.046950), "롯데시네마 도곡"),
        ((37.513803, 127.104056), "롯데시네마 월드타워"),
        ((37.538633, 127.073253), "롯데시네마 건대입구")
    ]
    private let megaboxList = [
        ((37.555991, 126.922044), "메가박스 홍대입구"),
        ((37.559769, 126.941903), "메가박스 신촌"),
        ((37.566741, 127.007481), "메가박스 DDP"),
        ((37.505081, 127.004037), "메가박스 센트럴시티"),
        ((37.498125, 127.026565), "메가박스 강남"),
        ((37.541994, 127.044672), "메가박스 성수"),
        ((37.512909, 127.058698), "메가박스 코엑스"),
        ((37.555770, 127.078391), "메가박스 군자"),
        ((37.526939, 126.874437), "메가박스 목동")
    ]

    private var showCinemaList: [(Coordinate, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.delegate = self
        showCinemaList = cgvList + lotteList + megaboxList
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
        configureAnnotation()
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
                latitudinalMeters: 5000,
                longitudinalMeters: 5000
            )
            mapView.setRegion(region, animated: true)
        }
    }

    func configureAnnotation() {
        mapView.removeAnnotations(mapView.annotations)
        showCinemaList.forEach {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.0.0, longitude: $0.0.1)
            annotation.title = $0.1
            mapView.addAnnotation(annotation)
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
