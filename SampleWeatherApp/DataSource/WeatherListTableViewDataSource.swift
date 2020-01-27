//
//  WeatherListTableViewDataSource.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 27/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import UIKit

class WeatherListTableViewDataSource:NSObject, UITableViewDataSource {
    
    private var weatherListViewModel:WeatherListViewModel
    
    init(_ weatherListViewModel:WeatherListViewModel) {
        self.weatherListViewModel = weatherListViewModel
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.weatherListViewModel.totalNumberOfElements()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherViewModel = self.weatherListViewModel.item(atIndex: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
//        cell.configureCell(weatherViewModel: weatherViewModel)
        
        return cell
    }
    
    
}

class WeatherListTableViewDelegate:NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
