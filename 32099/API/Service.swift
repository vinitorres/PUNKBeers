//
//  Service.swift
//  32099
//
//  Created by Vinicius Torres on 11/21/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import Foundation

class Service {
    
    private static let BASE_URL = "https://api.punkapi.com/v2/"
    
    private static let URL_GET_BEERS = "beers"
    
    static let configuration: URLSessionConfiguration = {
        
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 45.0
        config.httpMaximumConnectionsPerHost = 5
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        return config
    }()
    
    static let session = URLSession(configuration: configuration)
    
    static func getBeers(onComplete: @escaping (_ success: [Beer]?)->()) {
        
        guard let url = URL(string: BASE_URL + URL_GET_BEERS) else {
            onComplete(nil)
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Erro with session task")
                onComplete(nil)
            } else {
                
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                
                if response.statusCode == 200 {
                    
                    guard let data = data else {
                        onComplete(nil)
                        return
                    }
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
                        
                        var beers: [Beer] = []
                        
                        for item in json {
                            let imageUrl = item["image_url"] as! String
                            let name = item["name"] as! String
                            let tagline = item["tagline"] as! String
                            let abv = item["abv"] as? Float ?? 0.0
                            let ibu = item["ibu"] as? Float ?? 0.0
                            let descriptionBeer = item["description"] as! String

                            let beer = Beer(imageUrl: imageUrl, name: name, tagline: tagline, abv: abv, ibu: ibu, descriptionBeer: descriptionBeer)
                            
                            beers.append(beer)
                        }
                        
                        onComplete(beers)
                        
                        
                    } catch {
                        print(error.localizedDescription)
                        onComplete(nil)
                    }
                } else {
                    print("Erro no servidor:", response.statusCode)
                    onComplete(nil)
                }
                
            }
            
        }
        
        dataTask.resume()
    }

}
