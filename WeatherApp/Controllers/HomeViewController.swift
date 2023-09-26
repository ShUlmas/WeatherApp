//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by O'lmasbek on 14/09/23.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    //MARK: - PROPERTIES
    private var homeView = HomeView()

    let searchBar = UISearchBar()
    
    //MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWeather()
    }
    
    //MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setUpNavigationBar()
        setUpSearchbar()
        
        
    }
    //MARK: - FUNCTIONS
    
    func getWeather() {
        LocationManager.shared.getCurrentLocation { location in
            NetworkManager.shared.getWeatherWithCoordinate(location: location) { [weak self] in
                DispatchQueue.main.async {
                    
                    let currentWeather = NetworkManager.shared.currentWeather
                    guard let currentWeather = currentWeather else { return }

                    self?.homeView.configure(with: [
                        .current(viewModel: .init(currentWeather: currentWeather)),
                        .hourly(viewModel: NetworkManager.shared.hourlyWeather.compactMap {.init(hourlyWeather: $0)}),
                        .weekly(viewModel: NetworkManager.shared.weeklyWeather.compactMap {.init(weeklyWeather: $0)})
                    ])
                }
            }
        }
    }
    
    
    private func setupUI() {
        self.view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setUpSearchbar() {
        searchBar.delegate = self
        searchBar.placeholder = "City name..."
        navigationItem.titleView = searchBar
    }
    
    private func setUpNavigationBar() {
        // location button
        let locationButton = UIBarButtonItem(image: UIImage(systemName: "location.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)), style: .done, target: self, action: #selector(lcoationButtonTapped))
        locationButton.tintColor = .label
        navigationItem.leftBarButtonItem = locationButton
        // search button
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)), style: .done, target: self, action: #selector(searchButtonTapped))
        searchButton.tintColor = .label
        navigationItem.rightBarButtonItem = searchButton
    }
    @objc
    func lcoationButtonTapped() {
        
    }
    
    @objc
    func searchButtonTapped() {
        
    }
}

//MARK: - Searchbar delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            // Qidiruv tugaganda, qidiruv natijasini qilib ishlatishingiz mumkin
            print("Qidiruv natijasi: \(searchText)")
        }
    }
}
