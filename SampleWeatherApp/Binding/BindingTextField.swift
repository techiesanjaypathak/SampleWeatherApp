//
//  BindingTextField.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 27/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    var textChangeClosure: (String) -> () = { _ in }
    
    func bind(callback: @escaping (String) -> ()){
        self.textChangeClosure = callback
    }
    
    private func commonInit(){
        self.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    @objc func textFieldChange(_ textField:UITextField) {
        if let str = textField.text {
            self.textChangeClosure(str)
        }
    }
}
