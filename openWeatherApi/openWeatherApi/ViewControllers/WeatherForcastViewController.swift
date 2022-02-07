//
//  ViewController.swift
//  openWeatherApi
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import UIKit

class WeatherForcastViewController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var highLowTempLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feelLikeLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    
    var viewModel: WeatherForcastViewModel!
    var weatherResult: WeatherResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        self.view.addGradient()
        intialiseViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getWeatherForcast()
    }
    
    private func registerNib() {
        let weatherForcastNib = UINib(nibName: WeatherForcastTableViewCell.identifier(), bundle: nil)
        tableView.register(weatherForcastNib, forCellReuseIdentifier: WeatherForcastTableViewCell.identifier())
    }
    
    private func intialiseViewModel()  {
        viewModel = WeatherForcastViewModel(repo: WeatherFocastApi())
        viewModel.forcastDataDelegate = self
    }
    
}

extension WeatherForcastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dailyForcast?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForcastTableViewCell.identifier()) as? WeatherForcastTableViewCell {
            if let dailyForcastData = viewModel.dailyForcast {
                cell.populateData(dailyForcast: dailyForcastData[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension WeatherForcastViewController: ForcastDataProtocol {
    
    func updateWeatherData(currentForcast: CurrentWeather){
        updateCurrentWeather(currentWeather: currentForcast)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension WeatherForcastViewController {
    
    private func updateCurrentWeather(currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            if let weatherCondition = currentWeather.weather?.first {
                self.weatherIcon.image = UIImage(systemName: weatherCondition.getWeatherIcon(weatherCondition: weatherCondition.main!))
                self.weatherTypeLbl.text = weatherCondition.main
            }
            
            if let temp = currentWeather.temp {
                self.tempLbl.text = String(format: "%.0fº", temp.kelvinToCelcius())
            }
            self.feelLikeLbl.text = String(format: "Feel Like: %.0fº", currentWeather.feelsLike?.kelvinToCelcius() ?? "N/A")
            self.highLowTempLbl.text = String(format: "Humidity: %.0f%%", currentWeather.humidity ?? "N/A")
        }
        
    }
}
