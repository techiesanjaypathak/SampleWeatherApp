//
//  WeatherListViewModel.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 25/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    private(set) var weatherViewModels = [WeatherViewModel]()
    
    func addWeatherVM(vm:WeatherViewModel) {
        weatherViewModels.append(vm)
    }
    
    func totalNumberOfElements() -> Int {
        return weatherViewModels.count
    }
    
    func item(atIndex:Int) -> WeatherViewModel {
        return weatherViewModels[atIndex]
    }
    
    func updateUnit(to unit: Unit) {
        switch unit {
        case .celsius:
            toCelsius()
        case .farenheight:
            toFarenheight()
        }
    }
    
    private func toCelsius(){
        self.weatherViewModels = self.weatherViewModels.map { (wm) -> WeatherViewModel in
            let weatherModel = wm
            weatherModel.cityTemperature.temperature.value = (weatherModel.cityTemperature.temperature.value - 32) * 5/9
            return weatherModel
        }
    }
    
    private func toFarenheight(){
        self.weatherViewModels = self.weatherViewModels.map { (wm) -> WeatherViewModel in
            let weatherModel = wm
            weatherModel.cityTemperature.temperature.value = (weatherModel.cityTemperature.temperature.value - 9/5) + 32
            return weatherModel
        }
    }
}
