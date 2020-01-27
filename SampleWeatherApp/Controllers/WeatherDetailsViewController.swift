//
//  WeatherDetailsViewController.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 27/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    var weatherVM: WeatherViewModel?
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Old way of doing without binding
//        cityNameLabel.text = self.weatherVM?.name.value
//        temperatureLabel.text = self.weatherVM?.cityTemperature.temperature.value.formatAsDegree()
//        minTempLabel.text = self.weatherVM?.cityTemperature.temperatureMin.value.formatAsDegree()
//        maxTempLabel.text = self.weatherVM?.cityTemperature.temperatureMax.value.formatAsDegree()
        setupVMBindings()
    }
    
    private func setupVMBindings(){
        if let weatherVM = self.weatherVM {
            weatherVM.name.bind {
                self.cityNameLabel.text = $0
            }
            weatherVM.cityTemperature.temperature.bind{
                self.temperatureLabel.text = $0.formatAsDegree()
            }
            weatherVM.cityTemperature.temperatureMin.bind{
                self.minTempLabel.text = $0.formatAsDegree()
            }
            weatherVM.cityTemperature.temperatureMax.bind{
                self.maxTempLabel.text = $0.formatAsDegree()
            }
        }
        
        // Advantage of using Binding - View automatically gets updated when the model gets updated
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.weatherVM?.name.value = "Kolkata"
        }
    }

}
