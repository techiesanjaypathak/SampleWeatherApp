//
//  WeatherListTableViewController.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 25/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import UIKit

class WeatherListTableViewController: UITableViewController {
    
    private var weatherListViewModel = WeatherListViewModel()
//    private var weatherListDataSource: WeatherListTableViewDataSource?
    private var weatherListDataSource:TableViewDataSource<WeatherTableViewCell>?
    private var weatherListTableViewDelegate: WeatherListTableViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        weatherListDataSource = WeatherListTableViewDataSource(weatherListViewModel)
        weatherListDataSource = TableViewDataSource(viewModelItems: weatherListViewModel.weatherViewModels)
        self.tableView.dataSource = weatherListDataSource
        weatherListTableViewDelegate = WeatherListTableViewDelegate()
        self.tableView.delegate = weatherListTableViewDelegate
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case "AddCityNavSegue":
                guard let nav = segue.destination as? UINavigationController else {
                    fatalError("Segue not found")
                }
                if let addCityVC = nav.viewControllers[0] as? AddCityViewController {
                    addCityVC.delegate = self
                }
            case "SettingsSegue":
                prepareSegueForSettings(segue: segue)
            case "WeatherDetailsViewController":
                prepareSegueForWeatherDetailsViewController(segue: segue)
            default:
                print("Unhandled Segue")
            }
        }
    }
    
    private func prepareSegueForSettings(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("Segue not found")
        }
        if let settingsVC = nav.viewControllers[0] as? SettingsTableViewController {
            settingsVC.delegate = self
        }
    }
    
    private func prepareSegueForWeatherDetailsViewController(segue: UIStoryboardSegue) {
        guard let weatherDetailsVC = segue.destination as? WeatherDetailsViewController,
            let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Segue not found")
        }
        weatherDetailsVC.weatherVM = self.weatherListViewModel.item(atIndex: indexPath.row)
    }
}

extension WeatherListTableViewController: AddWeatherDelegate {
    func addWeatherDidSave(weatherViewModel: WeatherViewModel) {
        self.weatherListViewModel.addWeatherVM(vm: weatherViewModel)
        weatherListDataSource?.updateViewModel(withViewModelItems:self.weatherListViewModel.weatherViewModels)
        self.tableView.reloadData()
    }
}

extension WeatherListTableViewController: SettingsDelegate {
    func settingsDone(vm: SettingsViewModel) {
        self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
        self.tableView.reloadData()
    }
}
