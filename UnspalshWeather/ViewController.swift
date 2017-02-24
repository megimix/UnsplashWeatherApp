//
//  ViewController.swift
//  UnspalshWeather
//
//  Created by Tal Shachar on 11/02/2017.
//  Copyright © 2017 Tal Shachar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a ni
        
        API().testAPI(key: "", value: "") { (success, object , message) -> () in
            print(object ?? "return nil")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

