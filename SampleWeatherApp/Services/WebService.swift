//
//  WebService.swift
//  SampleWeatherApp
//
//  Created by SanjayPathak on 25/01/20.
//  Copyright © 2020 Sanjay. All rights reserved.
//

import Foundation

struct Resource<T>{
    let url:URL
    let parse:(Data) -> T?
}

class WebService {
    func load<T>(resource: Resource<T>, completion: @escaping (T?)->Void) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
