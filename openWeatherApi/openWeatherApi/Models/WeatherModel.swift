//
//  WeatherModel.swift
//  openWeatherApi
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import Foundation


struct WeatherResult: Codable {
    let lat, lon: Double?
    let timezone: String?
    let timezoneOffset: Int?
    let current: CurrentWeather?
    let daily: [Daily]?
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, daily
    }
}

// MARK: - Current
struct CurrentWeather: Codable {
    let dt, sunrise, sunset: Int?
    let temp, feelsLike: Double?
    let pressure, humidity: Int?
    let dewPoint, uvi: Double?
    let clouds, visibility: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let weather: [Weather]?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    func getWeatherIcon(weatherCondition: String) -> String {
        switch weatherCondition {
        case  WeatherCondition.clear.rawValue:
            return "sun.min.fill"
        case  WeatherCondition.rain.rawValue:
            return "cloud.bolt.rain.fill"
        case  WeatherCondition.cloudy.rawValue:
            return "cloud.fog.fill"
        case  WeatherCondition.smoke.rawValue:
            return "smoke.fill"
        default:
            return ""
        }
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int?
    let moonset: Int?
    let moonPhase: Double?
    let temp: Temp?
    let feelsLike: FeelsLike?
    let pressure, humidity: Int?
    let dewPoint, windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let weather: [Weather]?
    let clouds: Int?
    let pop, uvi, rain: Double?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double?
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double?
    let eve, morn: Double?
}

enum WeatherCondition: String {
    case clear = "Clear"
    case cloudy = "Clouds"
    case rain = "Rain"
    case smoke = "Smoke"
}

