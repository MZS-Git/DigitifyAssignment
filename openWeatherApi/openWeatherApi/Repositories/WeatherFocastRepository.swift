//
//  WeatherFocastRepository.swift
//  openWeatherApi
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import Foundation
import CoreLocation

protocol AppDataSerializerProtocol {
    func parseData<T: Codable>(data: Data, ofType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

protocol WeatherFocastRepository {
    func getWeatherForcast(currentCoordinates: CLLocation, completion: @escaping(Result<WeatherResult, Error>) -> Void )
}

class AppDataSerializer: AppDataSerializerProtocol {
    func parseData<T: Codable>(data: Data, ofType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        do{
            let result = try JSONDecoder().decode(ofType.self, from: data)
            completion(.success(result))
        }
        catch {
            completion(.failure(error))
        }
    }
}

//MARK: API Data
class WeatherFocastApi: AppDataSerializer,  WeatherFocastRepository {
    
    func getWeatherForcast(currentCoordinates: CLLocation, completion: @escaping (Result<WeatherResult, Error>) -> Void) {
        
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(currentCoordinates.coordinate.latitude)&lon=\(currentCoordinates.coordinate.longitude)&exclude=hourly,minutely&appid=ef5a07fa23c787fe2f850babbc7d7e80"
        
        NetworkService.sharedInstance.getDataFromApi(urlString: url) { result in
            switch result {
            case .success(let data):
                self.parseData(data: data, ofType: WeatherResult.self) { result in
                    switch result {
                    case .success(let weatherResult):
                        completion(.success(weatherResult))
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                switch error {
                case .dataError:
                    print("Data Error")
                case .badUrl:
                    print("BadUrl Error")
                case .serverError:
                    print("Server Error")
                }
            }
        }
    }
}

//MARK: For MockData
class WeatherFocastMock: WeatherFocastRepository {
    
    func getWeatherForcast(currentCoordinates: CLLocation, completion: @escaping (Result<WeatherResult, Error>) -> Void) {
        print("Mockdata")
    }
}
