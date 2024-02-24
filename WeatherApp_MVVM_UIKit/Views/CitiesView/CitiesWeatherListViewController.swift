//
//  CitiesWeatherListViewController.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 07/02/24.
//

import UIKit

class CitiesWeatherListViewController: UIViewController {
    
    //MARK: - UI
    private let searchBar = UISearchBar()
    
    override var inputAccessoryView: UIView? {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let searchButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(searchButtonTapped))
        toolbar.items = [flexibleSpace, searchButton]
        return toolbar
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Cities", "Pinned cities"])
        sc.selectedSegmentIndex = 0
        let font = UIFont.systemFont(ofSize: 18, weight: .black)
        sc.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    //MARK: - VARIABLES
    private let viewModel = CitiesWeatherListViewViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            navigationItem.titleView = searchBar
            viewModel.cellViewModels = viewModel.cities.map { CityTableViewCellViewModel(city: $0, isPin: false) }
            tableView.reloadData()
            
        case 1:
            navigationItem.titleView = nil
            viewModel.pinnedCities = StorageManager.shared.loadCities() ?? []
            viewModel.cellViewModels = viewModel.pinnedCities.map { CityTableViewCellViewModel(city: $0, isPin: true) }
            tableView.reloadData()
        default:
            break
        }
    }
    
    //MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(segmentedControl, tableView)
        setUpNavigationBar()
        setupSearchBar()
        addConstraints()
        setupTableView()
        delegatesSelf()
        segmentedControl.addTarget(self, action: #selector(segmentedControlSwitch(_ :)), for: .valueChanged)
    }
    
    //MARK: - FUNCTIONS
    private func setUpNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .black),
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            segmentedControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search for city"
        navigationItem.titleView = searchBar
        searchBar.inputAccessoryView = inputAccessoryView
    }
    
    private func setupTableView() {
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.cellIdentifier)
    }
    
    func delegatesSelf() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    //MARK: - Actions
    @objc func searchButtonTapped() {
        searchBar.resignFirstResponder()
    }
    
    @objc func segmentedControlSwitch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            navigationItem.titleView = searchBar
            viewModel.cellViewModels = viewModel.cities.map { CityTableViewCellViewModel(city: $0, isPin: false) }
            tableView.reloadData()
        case 1:
            navigationItem.titleView = nil
            viewModel.pinnedCities = StorageManager.shared.loadCities() ?? []
            viewModel.cellViewModels = viewModel.pinnedCities.map { CityTableViewCellViewModel(city: $0, isPin: true) }
            checkPinnedCitiesIsEmpty()
            tableView.reloadData()
        default:
            break
        }
    }
    
    private func checkTableViewForSearch(text: String) {
        if text.isEmpty {
            viewModel.fetchCities()
        } else {
            viewModel.fetchSearchedCities(with: text)
        }
        tableView.reloadData()
    }
    
    private func checkPinnedCitiesIsEmpty() {
        if self.viewModel.pinnedCities.isEmpty {
            self.emptyLabel.text = self.viewModel.emptyViewText
            self.tableView.backgroundView = self.emptyLabel
        } else {
            self.tableView.backgroundView = nil
        }
    }
}

//MARK: - UISEARCHBARDELEGATE
extension CitiesWeatherListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        checkTableViewForSearch(text: searchText)
    }
}

//MARK: - UITABLEVIEWDELEGATE, UITABLEVIEWDATASOURCE
extension CitiesWeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.cellIdentifier, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        let cityViewModel = viewModel.cellViewModels[indexPath.row]
        cell.configureCell(with: cityViewModel)
        cell.pinButtonAction = {
            if cityViewModel.isPin {
                self.viewModel.removeCity(City(name: cityViewModel.cityName))
                self.viewModel.pinnedCities = StorageManager.shared.loadCities() ?? []
                self.viewModel.cellViewModels = self.viewModel.pinnedCities.map { CityTableViewCellViewModel(city: $0, isPin: true) }
                
                self.checkPinnedCitiesIsEmpty()
            } else {
                self.viewModel.addCity(City(name: cityViewModel.cityName))
            }
            tableView.reloadData()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityName = viewModel.cellViewModels[indexPath.row].cityName
        let vc = WeatherViewController(cityName: cityName)
        navigationController?.pushViewController(vc, animated: true)
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
