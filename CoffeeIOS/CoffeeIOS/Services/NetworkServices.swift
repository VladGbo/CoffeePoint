//
//  Services.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/5/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkServices {
    
    private let url:URL
    typealias WebServiceResponce = ([String: Any]?, Error?) -> Void
    typealias WebServiceResponceArrey = ([[String: Any]]?, Error?) -> Void
    
    init?(url:String) {
        guard let a = URL(string: url) else { return nil }
        self.url = a
    }
 
    func login (data:String, completion: @escaping WebServiceResponce){
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let data = data
        request.httpBody = data.data(using: .utf8)
        
        AF.request(request).responseJSON { (responce) in
            if let error = responce.error {
                completion(nil, error)
            } else if let jsonDict = responce.result.value as? [String:Any] {
                completion(jsonDict, nil)
            }
        }
    }
    func getInfoFromService(completion: @escaping WebServiceResponceArrey) {
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                completion(nil, error)
            } else if let json = response.value as? [[String: Any]]{
                completion(json, nil)
            }
        }
    }
}
