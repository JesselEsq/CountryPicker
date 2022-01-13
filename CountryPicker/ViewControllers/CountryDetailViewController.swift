//
//  CountryDetailViewController.swift
//  CountryPicker
//
//  Created by Jessel Esquinas on 1/13/22.
//

import Foundation
import UIKit

class CountryDetailViewController: UIViewController {
    
    @IBOutlet weak private var countryImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var topLevelDomainLabel: UILabel!
    @IBOutlet weak private var regionLabel: UILabel!
    @IBOutlet weak private var capitalLabel: UILabel!
    @IBOutlet weak private var alphaCodesLabel: UILabel!
    @IBOutlet weak private var callingCodesLabel: UILabel!
    @IBOutlet weak private var altSpellingValuesLabel: UILabel!
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let country = country else {
            return
        }
        AppImageLoader().loadImage(for: countryImageView, with: country.flagImageURLString())
        setupLabels()
    }
    
    private func setupLabels() {
        guard let country = country else {
            return
        }
        let nameString = "COUNTRY NAME: \(country.name)"
        nameLabel.attributedText = nameString.countrify("COUNTRY NAME:")
        
        let topLevelDomains = (country.topLevelDomain.map{$0}).joined(separator: ", ")
        let domainString = "TOP LEVEL DOMAIN/S: \(topLevelDomains)"
        topLevelDomainLabel.attributedText = domainString.countrify("TOP LEVEL DOMAIN/S:")
        
        let regionString = "REGION: \(country.region)"
        regionLabel.attributedText = regionString.countrify("REGION:")
        
        let capitalString = "CAPITAL: \(country.region)"
        capitalLabel.attributedText = capitalString.countrify("CAPITAL:")
        
        let alphaCodeString = "ALPHA CODES: \(country.alpha2Code), \(country.alpha3Code)"
        alphaCodesLabel.attributedText = alphaCodeString.countrify("ALPHA CODES:")

        let callingCodes = (country.callingCodes.map{$0}).joined(separator: ", ")
        let callingCodesString = "CALLING CODE/S: \(callingCodes)"
        callingCodesLabel.attributedText = callingCodesString.countrify("CALLING CODE/S:")
        
        let altSpellings = (country.altSpellings.map{$0}).joined(separator: ", ")
        let altSpellingString = "ALT SPELLING/S: \(altSpellings)"
        altSpellingValuesLabel.attributedText = altSpellingString.countrify("ALT SPELLING/S:")
    }
}

