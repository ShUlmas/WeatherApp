//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by O'lmasbek on 25/09/23.
//

import Foundation

enum WeatherViewModel {
    case current(viewModel: CurrentWeatherCVCViewModel)
    case hourly(viewModel: [HourlyWeatherCVCViewModel])
    case weekly(viewModel: [WeeklyWeatherCVCViewModel])
}
