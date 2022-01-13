//
//  CountryAPI.swift
//  CountryPicker
//
//  Created by Jessel Esquinas on 1/13/22.
//

import Foundation

struct CountryAPI {
    
    func getCountries() {
        let param = ["access_key": "59c905faee68e520e17ae32552a75982"]
        
    }
    
    static func getCountries(completionHandler: @escaping ([Country]) -> Void) {
        let urlComponents = NSURLComponents(string: "http://api.countrylayer.com/v2/all")!

        urlComponents.queryItems = [
          URLQueryItem(name: "access_key", value: "59c905faee68e520e17ae32552a75982")
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            let countries = try! JSONDecoder().decode([Country].self, from: data!)
            completionHandler(countries)
        })
        task.resume()
    }
    
}
