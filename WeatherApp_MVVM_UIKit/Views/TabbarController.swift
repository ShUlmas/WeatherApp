//
//  TabbarController.swift
//  WeatherApp_MVVM_UIKit
//
//  Created by O'lmasbek on 11/02/24.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let blur = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.addSubview(blurView)
        generateTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: UINavigationController.init(rootViewController: WeatherViewController(cityName: "")),
                title: "Weather",
                image: UIImage(systemName: "cloud.sun.fill")
            ),
            generateVC(
                viewController: UINavigationController.init(rootViewController: CitiesWeatherListViewController()),
                title: "Cities",
                image: UIImage(systemName: "globe.central.south.asia.fill")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}
