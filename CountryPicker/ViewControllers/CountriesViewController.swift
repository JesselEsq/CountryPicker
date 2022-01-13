//
//  ViewController.swift
//  CountryPicker
//
//  Created by Jessel Esquinas on 1/13/22.
//

import UIKit

class CountriesViewController: UIViewController {

    @IBOutlet weak private var countriesTableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    private let refreshControl = UIRefreshControl()
    private var countries = [Country]()
    private var filteredCountries = [Country]()
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCountries()
        setupTableView()
        setupRefreshControl()
        setupSearchBar()
    }
    
    @objc
    private func fetchCountries() {
        CountryAPI.getCountries(completionHandler: { [weak self] countries in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.countries = countries
                self?.countriesTableView.reloadData()
            }
        })
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.register(CountryCell.nib(), forCellReuseIdentifier: CountryCell.nibName())
        countriesTableView.estimatedRowHeight = 80
        countriesTableView.rowHeight = 80
        
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(fetchCountries), for: .valueChanged)
        countriesTableView.refreshControl = refreshControl
    }
    
    private func getItem(_ indexPath: IndexPath) -> Country {
        if isSearching {
            return filteredCountries[indexPath.row]
        } else {
            return countries[indexPath.row]
        }
    }

}

// MARK: - UITableViewDelegate
extension CountriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = getItem(indexPath)
        let countryDetail = CountryDetailViewController()
        countryDetail.country = country
        let navigationViewController = UINavigationController(rootViewController: countryDetail)
        navigationViewController.navigationBar.isHidden = false
        navigationController?.pushViewController(countryDetail, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredCountries.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: CountryCell.nibName())
        guard let cell = dequeuedCell as? CountryCell else {
            return UITableViewCell()
        }
        let country = getItem(indexPath)
        cell.countryNameLabel.text = country.name
        AppImageLoader().loadImage(for: cell.countryImageView, with: country.flagImageThumbURLString())
        
        return cell
    }
    
}

// MARK: - UITableViewDataSource
extension CountriesViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        filteredCountries.removeAll()
        countriesTableView.reloadData()
        return
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredCountries.removeAll()
            countriesTableView.reloadData()
            return
        }
        filteredCountries = countries.filter({
            $0.name.lowercased().contains(searchText.lowercased())
        })
        isSearching = true
        countriesTableView.reloadData()
    }
    
}

