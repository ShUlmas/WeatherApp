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
    var collectionView: UICollectionView?
    
    let locationManager = CLLocationManager()
    let searchBar = UISearchBar()
    
    let currentWeatherViewModel = CurrentWeatherCVCViewModel()
    let hourlyWeatherViewModel = HourlyWeatherCVCViewModel()
    let weeklyWeatherViewModel = WeeklyWeatherCVCViewModel()
       
    var manager = NetworkManager()
    
    //MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hourlyWeatherViewModel.getHourlyWeather()
        weeklyWeatherViewModel.getWeeklyWeather()
        currentWeatherViewModel.getCurrentWeather()
        
    }
    
    //MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        setUpNavigationBar()
        let collectionView = CreateCollectionView.shared.createCollectionView()
        self.collectionView = collectionView
        collectionView.showsVerticalScrollIndicator = false
        setUpCollectionView()
        collectionView.backgroundColor = .clear

        collectionView.dataSource = self
        collectionView.delegate = self
        locationManager.delegate = self
        
        //Location manager
        
        
        setUpSearchbar()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters // Set desired accuracy
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    //MARK: - FUNCTIONS
    
    private func setUpSearchbar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
    }
    
    private func setUpCollectionView() {
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setUpNavigationBar() {
        
        let locationButton = UIBarButtonItem(image: UIImage(systemName: "location.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)), style: .done, target: self, action: #selector(lcoationButtonTapped))
        locationButton.tintColor = .systemIndigo
        navigationItem.leftBarButtonItem = locationButton
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)), style: .done, target: self, action: #selector(searchButtonTapped))
        searchButton.tintColor = .systemIndigo
        navigationItem.rightBarButtonItem = searchButton
    }
    @objc
    func lcoationButtonTapped() {
        locationManager.requestLocation()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    @objc
    func searchButtonTapped() {
        print("search")
    }
}


//MARK: - CLLocationManagerDelegate


extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation() // Start receiving location updates
        }
    }
    
    // Delegate method called when the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // You can access the current location via the 'location' variable
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            UserDefaults.standard.set(lat, forKey: "latitude")
            UserDefaults.standard.set(lon, forKey: "longitude")
        }
    }
    
    // Delegate method called when an error occurs while getting the location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}


//MARK: -  UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return hourlyWeatherViewModel.hourlyWeather.count
        } else {
            return weeklyWeatherViewModel.weeklyWeather.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? CurrentWeatherCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = currentWeatherViewModel.currentWeather
            cell.configure(with: model)
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? HourlyWeatherCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = hourlyWeatherViewModel.hourlyWeather[indexPath.item]
            cell.configure(with: model)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? WeeklyWeatherCollectionViewCell else {
                return UICollectionViewCell()
            }
            let model = weeklyWeatherViewModel.weeklyWeather[indexPath.item]
            cell.configure(model: model)
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
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
