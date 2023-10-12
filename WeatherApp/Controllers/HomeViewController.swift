//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by O'lmasbek on 14/09/23.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewViewModel()
    
    //MARK: - PROPERTIES
    
    private var collectionView: UICollectionView?
    
    private let searchBar = UISearchBar()
 

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        gradientBackground()
        setUpCollectionView()
        setUpNavigationBar()
        setUpSearchbar()
    }
    //MARK: - FUNCTIONS
    
    private func gradientBackground() {
        let gradientView = UIView()
        gradientView.frame = view.bounds
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.6196078431, green: 0.8666666667, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.4621385932, green: 0.6721127033, blue: 0.9318496585, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientView.layer.addSublayer(gradientLayer)
        view.addSubview(gradientView)
    }
    
    private func setUpCollectionView() {
        
        let collectionVieww = createCollectionView()
        self.collectionView = collectionVieww
        collectionVieww.backgroundColor = .clear
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.layout(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(CurrentWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(WeeklyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeeklyWeatherCollectionViewCell.cellIdentifier)
        return collectionView
    }
    
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        switch sectionIndex {
        case 0:
            return currentWeatherInfoSection()
        case 1:
            return hourlyWeatherInfoSection()
        case 2:
            return weeklyWeatherInfoSection()
        default:
            break
        }
        return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: .init(widthDimension: .absolute(0), heightDimension: .absolute(0))))
    }
    
    //MARK: - Create section
    private func currentWeatherInfoSection() -> NSCollectionLayoutSection {
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
    
    private func hourlyWeatherInfoSection() -> NSCollectionLayoutSection {
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
    
    private func weeklyWeatherInfoSection() -> NSCollectionLayoutSection {
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
    
    
    
    private func setUpSearchbar() {
        searchBar.delegate = self
        searchBar.placeholder = "City name..."
        navigationItem.titleView = searchBar
    }
    
    private func setUpNavigationBar() {
        // location button
        let locationButton = UIBarButtonItem(image: UIImage(systemName: "location.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)), style: .done, target: self, action: #selector(lcoationButtonTapped))
        locationButton.tintColor = .label
        navigationItem.leftBarButtonItem = locationButton
        // search button
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)), style: .done, target: self, action: #selector(searchButtonTapped))
        searchButton.tintColor = .label
        navigationItem.rightBarButtonItem = searchButton
    }
    @objc private
    func lcoationButtonTapped() {
        viewModel.getWeather()
        collectionView?.reloadData()
    }
    
    @objc private
    func searchButtonTapped() {
        LocationManager.shared.updateLocation(location: searchBar.text ?? "")
        collectionView?.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return viewModel.houryWeather.count
        } else if section == 2 {
            return viewModel.weekyWeather.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? CurrentWeatherCollectionViewCell else {
                fatalError("unsupported")
            }
            cell.configure(model: viewModel.currentWeather)
            cell.layer.cornerRadius = 12
            return cell
        }
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? HourlyWeatherCollectionViewCell else {
                fatalError("unsupported")
            }
            cell.configure(model: viewModel.houryWeather[indexPath.item])
            return cell
        }
        
        if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? WeeklyWeatherCollectionViewCell else {
                fatalError("unsupported")
            }
            cell.configure(model: viewModel.weekyWeather[indexPath.item])
            
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: - Searchbar delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            print("Qidiruv natijasi: \(searchText)")
        }
    }
}
