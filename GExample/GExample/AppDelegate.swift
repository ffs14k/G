//
//  AppDelegate.swift
//  GExample
//
//  Created by Eugene on 08.03.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func createTabBar() -> UITabBarController {
        
        let tableExampleView = GTableExampleViewController()
        let tableExampleViewModel = GTableExampleViewModel()
        
        tableExampleView.viewModel = tableExampleViewModel
        tableExampleViewModel.view = tableExampleView
        
        tableExampleView.tabBarItem = UITabBarItem(title: "Table", image: nil, selectedImage: nil)
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            tableExampleView
        ]
        
        return tabBar
    }

}

