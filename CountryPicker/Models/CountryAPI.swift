//
//  CountryAPI.swift
//  CountryPicker
//
//  Created by Jessel Esquinas on 1/13/22.
//

import Foundation

struct CountryAPI {
    
    static func getCountries(completionHandler: @escaping ([Country], Error?) -> Void) {
        guard let urlComponents = NSURLComponents(string: "http://api.countrylayer.com/v2/all") else {
            return
        }
        urlComponents.queryItems = [
          URLQueryItem(name: "access_key", value: "59c905faee68e520e17ae32552a75982")
        ]
        guard let componentUrl = urlComponents.url else {
            return
        }
        var request = URLRequest(url: componentUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let error = error {
                completionHandler([], error)
            } else if let data = data {
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completionHandler(countries, nil)
                } catch let jsonError {
                    completionHandler([], jsonError)
                }
            }
        })
        task.resume()
    }
    
}
