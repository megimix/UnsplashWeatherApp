//
//  ViewController.swift
//  UnspalshWeather
//
//  Created by Tal Shachar on 11/02/2017.
//  Copyright © 2017 Tal Shachar. All rights reserved.
//

import UIKit
//import DarkSkyKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a ni
        
        API().testAPI(key: "", value: "") { (success, object , message) -> () in
            print(object ?? "return nil")
        }
        
//        let forecastClient = DarkSkyKit(apiToken: "ba613922715623169dc0fcfc2e8ca2d3")
//        
//        forecastClient.current(latitude: 0.34565, longitude: 1.64559) { result in
//            switch result {
//            case .success(let forecast):
//                // Manage weather data using the Forecast model. Ex:
//                if let current = forecast.currently {
//                    let t = current.temperature
//                }
//            case .failure(let error):
//                // Manage error case
//                print(error)
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

