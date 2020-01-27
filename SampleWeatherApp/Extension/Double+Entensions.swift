//
//  Double+Entensions.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 26/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

extension Double{
    func formatAsDegree() -> String {
        String(format: "%.0f°", arguments: [self])
    }
}
