//
//  NetworkService.swift
//  openWeatherApi
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import Foundation

enum GenericError: Error {
    case badUrl
    case serverError
    case dataError
}

class NetworkService: NSObject {
    
    private override init() {}
    static let sharedInstance = NetworkService()
    
    func getDataFromApi(urlString: String, completionHandler: @escaping(Result<Data, GenericError>) -> Void){
        
        guard let url = URL(string: urlString) else {
            return completionHandler(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if error != nil  {
                completionHandler(.failure(.serverError))
            } else {
                if let data = data {
                    print(data as Any)
                    completionHandler(.success(data))
                }
            }
        }.resume()
    }
}
