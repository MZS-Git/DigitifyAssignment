//
//  String+Extension.swift
//  SolidTest
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import Foundation

extension Double {
    
    func dateFromUnix() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func kelvinToCelcius() -> Double {
        let maxKelvin = 273.15
        return (self - maxKelvin)
    }
}
