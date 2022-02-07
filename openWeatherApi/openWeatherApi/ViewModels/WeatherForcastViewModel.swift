//
//  WeatherForcastViewModel.swift
//  openWeatherApi
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import Foundation
import CoreLocation

protocol ForcastDataProtocol {
    func updateWeatherData(currentForcast: CurrentWeather)
}

class WeatherForcastViewModel {
    
    var forcastDataDelegate: ForcastDataProtocol?
    var dailyForcast: [Daily]?
    var timer: Timer!
    
    private var repo: WeatherFocastRepository!
    
    init(repo: WeatherFocastRepository) {
        self.repo = repo
    }
}

extension WeatherForcastViewModel {
    
    func getWeatherForcast() {
        if let currentLocation = CoreLocationManager.sharedInstance.currentlocation {
            timer.invalidate()
            repo.getWeatherForcast(currentCoordinates: CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)) {[weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let weatherResult):
                    if let dailyForcast = weatherResult.daily, let currentForcast = weatherResult.current {
                        self.dailyForcast = dailyForcast
                        self.forcastDataDelegate?.updateWeatherData(currentForcast: currentForcast)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                self.getWeatherForcast()
            }
        }
    }
}
