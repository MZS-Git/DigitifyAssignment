//
//  LocationManager.swift
//  openWeatherApi
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import UIKit
import CoreLocation


protocol UserCurrentCoordinateProtocol: AnyObject {
    func getUserLocation(coordinates: CLLocation)
}

class CoreLocationManager: NSObject {
    
    private override init() {}
    static let sharedInstance = CoreLocationManager()
    
    weak var delegate: UserCurrentCoordinateProtocol?
    var locationManager: CLLocationManager?
    var currentlocation: CLLocation? {
        didSet {
            if let currentlocation = currentlocation {
                locationManager?.stopUpdatingLocation()
            } else {
                print("Nil")
            }
        }
    }
    
    func requestLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
    }
}

extension CoreLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager!.startUpdatingLocation()
        } else if status == .notDetermined {
            locationManager?.requestAlwaysAuthorization()
            locationManager?.requestWhenInUseAuthorization()
            locationManager!.startUpdatingLocation()
        } else if status == .denied {
            locationManager!.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentlocation = location
        }
    }
}
