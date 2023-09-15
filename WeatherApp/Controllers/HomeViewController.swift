//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by O'lmasbek on 14/09/23.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    //MARK: - Properties
    var collectionView: UICollectionView?
    
    let locationManager = CLLocationManager()
    
    //MARK: - View Didload
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        collectionView.showsVerticalScrollIndicator = false
        setUpCollectionView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.backgroundColor = .systemBackground
        //setupUI()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters // Set desired accuracy
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    //MARK: - Functions
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
}

//MARK: - ADD CollectionViewCompositionalLayout

extension HomeViewController {
    //MARK: - CreateCollectionView
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { [self] sectionIndex, _ in
            switch sectionIndex {
            case 0 :
                return currentWeatherInfoSection()
            case 1 :
                return hourlyWeatherInfoSection()
            default:
                return weeklyWeatherInfoSection()
            }
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(CurrentWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(WeeklyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeeklyWeatherCollectionViewCell.cellIdentifier)
        
        return collectionView
    }
    //MARK: - Create section
    func currentWeatherInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func hourlyWeatherInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(80),
                heightDimension: .absolute(120)),
            subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 12, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func weeklyWeatherInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(66)),
            subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
        
        return section
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
            let long = location.coordinate.longitude
            
            // Use the location data as needed
            NetworkManager.shared.getWeatherWithCoordinate(lat: lat, long: long)
            print(lat)
            print(long)
        }
    }
    
    // Delegate method called when an error occurs while getting the location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}


//MARK: -  UICollectionViewDelegate, UICollectionViewDataSource


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 24
        } else {
            return 10
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
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? HourlyWeatherCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? WeeklyWeatherCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
}
