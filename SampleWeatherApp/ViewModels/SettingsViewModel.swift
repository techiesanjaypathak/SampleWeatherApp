//
//  SettingsViewModel.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 26/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

enum Unit:String, CaseIterable {
    case celsius = "imperial"
    case farenheight = "matric"
}

extension Unit {
    var displayName: String {
        get {
            switch self {
            case .celsius:
                return "Celsius"
            case .farenheight:
                return "Farenheight"
            }
        }
    }
}

struct SettingsViewModel {
    let units = Unit.allCases
    private var _selectedUnit : Unit = Unit.farenheight
    var selectedUnit: Unit {
        get {
            let userDefaults = UserDefaults.standard
            if let value = userDefaults.value(forKey: "unit") as? String {
                return Unit(rawValue: value)!
            }
            return _selectedUnit
        }
        set {
            _selectedUnit = newValue
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue.rawValue, forKey: "unit")
            userDefaults.synchronize()
        }
        
    }
}
