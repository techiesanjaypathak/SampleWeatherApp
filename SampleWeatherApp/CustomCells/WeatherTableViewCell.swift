//
//  WeatherTableViewCell.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 25/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel:UILabel!
    @IBOutlet weak var temperatureLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension WeatherTableViewCell : TableCellDelegate{
    typealias ViewModel = WeatherViewModel
    static var cellIdentifier: String = "WeatherTableViewCell"
    func configureCell(withViewModel weatherViewModel: WeatherViewModel) {
        self.cityNameLabel.text = weatherViewModel.name.value
        self.temperatureLabel.text = weatherViewModel.cityTemperature.temperature.value.formatAsDegree() 
    }
}
