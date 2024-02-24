//
//  CitiesWeatherListViewViewModel.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 07/02/24.
//

import Foundation


class CitiesWeatherListViewViewModel {
    
    private let dataFetcherService = DataFetcherService()
    var cellViewModels: [CityTableViewCellViewModel] = []
    private let storageManager = StorageManager.shared
    var pinnedCities: [City] = []
    var cities: [City] = []
    let emptyViewText = "No pinned city."
    
    init() {
        fetchCities()
    }
    
    func fetchCities() {
        dataFetcherService.readJSONFromFile { cities in
            self.cities = cities
            self.cellViewModels = self.cities.map { CityTableViewCellViewModel(city: $0)}
        }
    }

    func fetchSearchedCities(with searchText: String) {
        let filteredCities = cities.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        cellViewModels = filteredCities.map { CityTableViewCellViewModel(city: $0)}
    }
    
    func addCity(_ city: City) {
        let newCity = City(name: city.name)
        self.pinnedCities.append(newCity)
        self.storageManager.saveCities(self.pinnedCities)
    }

    func removeCity(_ city: City) {
        if let index = pinnedCities.firstIndex(where: { $0.name == city.name }) {
            pinnedCities.remove(at: index)
            storageManager.saveCities(pinnedCities)
        }
    }
    
    func loadCities() -> [City] {
        pinnedCities = storageManager.loadCities() ?? []
        return pinnedCities
    }

}
