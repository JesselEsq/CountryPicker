//
//  ViewController.swift
//  CountryPicker
//
//  Created by Jessel Esquinas on 1/13/22.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var countriesTableView: UITableView!
    private var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCountries()
        setupTableView()
    }
    
    private func fetchCountries() {
        CountryAPI.getCountries(completionHandler: { [weak self] countries in
            DispatchQueue.main.async {
                self?.countries = countries
                self?.countriesTableView.reloadData()
            }
        })
    }
    
    private func setupTableView() {
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.register(CountryCell.nib(), forCellReuseIdentifier: CountryCell.nibName())
        countriesTableView.estimatedRowHeight = 80
        countriesTableView.rowHeight = 80
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: CountryCell.nibName())
        guard let cell = dequeuedCell as? CountryCell else {
            return UITableViewCell()
        }
        let country = countries[indexPath.row]
        cell.countryNameLabel.text = country.name
        AppImageLoader().loadImage(for: cell.countryImageView, with: country.flagImageThumbURLString())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        let countryDetail = CountryDetailViewController()
        countryDetail.country = country
        let navigationViewController = UINavigationController(rootViewController: countryDetail)
        navigationViewController.navigationBar.isHidden = false
        navigationController?.pushViewController(countryDetail, animated: true)
    }

}

