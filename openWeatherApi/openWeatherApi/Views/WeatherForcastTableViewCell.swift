//
//  WeatherForcastTableViewCell.swift
//  SolidTest
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import UIKit

class WeatherForcastTableViewCell: UITableViewCell {
    
    //Mark:- IBOUTLETS
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var rainPredictionLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var forcastDayLbl: UILabel!
    @IBOutlet weak var minMaxTempLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateData(dailyForcast: Daily) {
        if let weatherCondition = dailyForcast.weather?.first {
            weatherTypeImageView.image = UIImage(systemName: weatherCondition.getWeatherIcon(weatherCondition: weatherCondition.main!))
        }
        rainPredictionLbl.text = "Rain: " + "\(dailyForcast.rain ?? 0)" + "%"
        humidityLbl.text = "Humidity: " + "\(dailyForcast.humidity ?? 0)" + "%"
        weatherTypeLbl.text = dailyForcast.weather?.first?.main ?? "N/A"
        forcastDayLbl.text = Double(dailyForcast.dt ?? 0).dateFromUnix()
        if let temp = dailyForcast.temp {
            if let max = temp.max, let min = temp.min {
                minMaxTempLbl.text = "H: " +  String(format: "%.0fº", max.kelvinToCelcius()) + "\tL: " +  String(format: "%.0fº", min.kelvinToCelcius())
            } else {
                minMaxTempLbl.text = "H: " + "N/A" + "\tL: " + "N/A"
            }
        }
    }
}
