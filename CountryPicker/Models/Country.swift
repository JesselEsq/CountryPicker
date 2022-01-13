//
//  Country.swift
//  CountryPicker
//
//  Created by Jessel Esquinas on 1/13/22.
//

struct Country: Codable {
    var name: String
    var topLevelDomain: [String]
    var alpha2Code: String
    var alpha3Code: String
    var callingCodes: [String]
    var capital: String
    var altSpellings: [String]
    var region: String
    
    func flagImageThumbURLString() -> String {
        return "https://raw.githubusercontent.com/hampusborgos/country-flags/main/png250px/\(self.alpha2Code.lowercased()).png"
    }
    
    func flagImageURLString() -> String {
        return "https://raw.githubusercontent.com/hampusborgos/country-flags/main/png1000px/\(self.alpha2Code.lowercased()).png"
    }
}
