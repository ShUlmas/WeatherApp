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
        collectionView.backgroundColor = .clear
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
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
        group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 16)
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
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        
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
//            NetworkManager.shared.getWeatherWithCoordinate(lat: lat, long: long)
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
            cell.layer.shadowColor = #colorLiteral(red: 0, green: 0.2745098039, blue: 0.5294117647, alpha: 1)
            cell.layer.shadowRadius = 5
            cell.layer.shadowOpacity = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? HourlyWeatherCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.layer.shadowColor = #colorLiteral(red: 0, green: 0.2745098039, blue: 0.5294117647, alpha: 1)
            cell.layer.shadowRadius = 5
            cell.layer.shadowOpacity = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? WeeklyWeatherCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.layer.shadowColor = #colorLiteral(red: 0, green: 0.2745098039, blue: 0.5294117647, alpha: 1)
            cell.layer.shadowRadius = 5
            cell.layer.shadowOpacity = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            return cell
        }
    }
}
