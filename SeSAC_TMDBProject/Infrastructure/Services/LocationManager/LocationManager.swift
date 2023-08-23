//
//  LocationManager.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/23.
//

import Foundation
import CoreLocation
import UIKit

protocol LocationManagerDelegate {
    func presentAuthorizationAlert(alert: UIAlertController)
}

final class LocationManager: NSObject {

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    private(set) var currenCoordinate: CLLocationCoordinate2D?

    var delegate: LocationManagerDelegate?

    private override init() {
        super.init()
        locationManager.delegate = self
    }
}

// MARK: - Methods

extension LocationManager {

    // 1. 기기 권한 확인
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {

                let authorization: CLAuthorizationStatus
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                // 위에서 권한 요청하고, 밑에서 권한 확인 로직으로 진입
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다")
            }
        }
    }

    // 2. 권한 상태 확인
    private func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 얼럿, infoplist
        case .restricted:
            print("restricted") // 자녀모드,,
            currenCoordinate = .init(latitude: 37.517829, longitude: 126.886270)
        case .denied:
            print("denied")
            currenCoordinate = .init(latitude: 37.517829, longitude: 126.886270)

            let alert = UIAlertController(
                title: "위치 정보가 필요해요",
                message: "'설정>개인정보 보호'에서 위치 서비스를 켜주세요",
                preferredStyle: .alert
            )
            let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)

            alert.addAction(goSetting)
            alert.addAction(cancel)

            delegate?.presentAuthorizationAlert(alert: alert)

        case .authorizedAlways:
            print("authorizedAlways")
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        default: print("default") // 위치 권한 종류가 더 생길 가능성 대비
        }

    }
}

// MARK: - CLLocationManagerDelegate 구현부

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let coordinate = locations.last?.coordinate {
            currenCoordinate = coordinate
            locationManager.stopUpdatingLocation()
        }
    }

    //사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    //사용자의 권한 상태가 바뀔 때를 알려줌
    //거부했다가 설정에서 변경을 했거나, 혹은 notDetermined 상태에서 허용을 했거나
    //허용해서 위치를 가지고 오는 도중에, 설정에서 거부를 하고 앱으로 다시 돌아올 때 등
    //iOS14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }

    //사용자의 권한 상태가 바뀔 때를 알려줌
    //iOS14 미만
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
}
