//
//  WeatherViewModel.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 25/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

// Type Eraser
class Dynamic<T>: Decodable where T:Decodable {
    
    typealias Listener = (T) -> ()
    var listener:Listener?
    
    func bind(listener:@escaping Listener){
        self.listener = listener
        self.listener?(value)
    }
    
    var value:T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    private enum CodingKeys : CodingKey {
        case value
    }
}

struct WeatherViewModel:Decodable {
    let name:Dynamic<String>
    var cityTemperature:TemperatureViewModel
    
    // Manual Decoding
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic(try container.decode(String.self, forKey: .name))
        cityTemperature = try container.decode(TemperatureViewModel.self, forKey: .cityTemperature)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case cityTemperature = "main"
    }
}

struct TemperatureViewModel: Decodable {
    var temperature: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    // Manual Decoding
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
        temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
