//
//  ViewController.swift
//  UnspalshWeather
//
//  Created by Tal Shachar on 11/02/2017.
//  Copyright © 2017 Tal Shachar. All rights reserved.
//

import UIKit
import DarkSkyKit
import UnsplashKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a ni
        
        API().testAPI(key: "", value: "") { (success, object , message) -> () in
            print(object ?? "return nil")
        }
        
        let forecastClient = DarkSkyKit(apiToken: "ba613922715623169dc0fcfc2e8ca2d3")
        
        forecastClient.current(latitude: 32.0853, longitude: 34.7818) { result in
            switch result {
            case .success(let forecast):
                // Manage weather data using the Forecast model. Ex:
                if let current = forecast.currently {
                    let t = current.temperature
                    print(t ?? "nil")
                }
            case .failure(let error):
                // Manage error case
                print(error)
            }
        }
        
        
        UnsplashSource().randomPhoto(fromCollection: "549790") { result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let image):
                    let imageview = UIImageView(image: image)
                    imageview.frame = CGRect(x: 0, y: 20, width: 300, height: 300)
                    self.view.addSubview(imageview)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        UnsplashSource().randomPhoto(fromSearch: ["nature", "water"]) { result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let image):
                    let imageview = UIImageView(image: image)
                    imageview.frame = CGRect(x: 0, y: 320, width: 300, height: 300)
                    self.view.addSubview(imageview)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

