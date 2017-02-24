//
//  API.swift
//  UnspalshWeather
//
//  Created by Tal Shachar on 11/02/2017.
//  Copyright © 2017 Tal Shachar. All rights reserved.
//

import Foundation

class API {
//    func login(email: String, password: String, completion: @escaping (_ success: Bool, _ message: String?) -> ()) {
//        let loginObject = ["email": email, "password": password]
//        
//        self.post(request: clientURLRequest(path: "http://demo6226482.mockable.io", params: loginObject as Dictionary<String, AnyObject>?)) { (success, object) -> () in
//            
//            DispatchQueue.main.async(execute: { () -> Void in
//                if success {
//                    completion(true, nil)
//                } else {
//                    var message = "there was an error"
//                    if let object = object, let passedMessage = object["message"] as? String {
//                        message = passedMessage
//                    }
//                    completion(true, message)
//                }
//            })
//        }
//    }
    
    func testAPI(key: String, value: String, completion: @escaping(_ success: Bool,_ respons: Dictionary<String, AnyObject>?,_ message: String?) -> ()) {
        let params = [key: value];
        self.post(request: clientURLRequest(path: "http://demo6226482.mockable.io", params: params as Dictionary<String, AnyObject>?)) { (success, object: Dictionary<String, AnyObject>?) ->() in
            if success {
                    completion(true, object, nil)
                } else {
                    var message = "there was an error"
                    if let object = object, let passedMessage = object["message"] as? String {
                        message = passedMessage
                    }
                    completion(true, object, message)
                }
        }
    }
    
    // MARK: private composition methods
    
    private func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Dictionary<String, AnyObject>?) -> ()) {
        self.dataTask(request: request, method: "POST", completion: completion)
    }
    
    private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Dictionary<String, AnyObject>?) -> ()) {
        self.dataTask(request: request, method: "GET", completion: completion)
    }
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: Dictionary<String, AnyObject>?) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                let responseData = String(data: data, encoding: String.Encoding.utf8)
                print(responseData!)
                
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let json = json as? Dictionary<String, AnyObject> {
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                            completion(true, json)
                    } else {
                        completion(false, json)
                    }
                }
                else {
                    completion(false, nil)
                }
            }
        }.resume()
    }
    
    private func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: URL(string: path)!)
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                
                let escapedKey = key.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
                let escapedValue = value.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        
        return request
    }
}
