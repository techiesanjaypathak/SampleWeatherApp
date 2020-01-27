//
//  AddCityViewController.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 25/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import UIKit

protocol AddWeatherDelegate:class {
    func addWeatherDidSave(weatherViewModel: WeatherViewModel)
}

class AddCityViewController: UIViewController {

    private var addCityVM = AddCityViewModel()
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var zipCodeTextField: BindingTextField! {
        didSet{
            zipCodeTextField.bind { (zipCode) in
                self.addCityVM.zipCode = zipCode
            }
        }
    }
    @IBOutlet weak var stateTextField: BindingTextField! {
        didSet{
            stateTextField.bind {
                self.addCityVM.stateName = $0
            }
        }
    }
    @IBOutlet weak var cityTextField: BindingTextField! {
        didSet{ // View to View Model Binding
            cityTextField.bind { (cityName) in
                self.addCityVM.cityName = cityName
            }
        }
    }
    weak var delegate: AddWeatherDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        print(self.addCityVM)
        if let cityName = cityTextField.text {
            performRequest(forCityName: cityName)
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func performRequest(forCityName cityName: String){
        guard let url = URL(string:"http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=f18d5799041f65322a7d7b2e8ba7fe6b") else {
            return
        }
        let resource = Resource<WeatherViewModel>(url: url) { data in
            print(data)
            let weatherViewModel = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
            return weatherViewModel
        }
        WebService().load(resource: resource) { [weak self] result in
            print(result ?? "")
            if let weatherViewModel = result {
                if let delegate = self?.delegate {
                    delegate.addWeatherDidSave(weatherViewModel: weatherViewModel)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
