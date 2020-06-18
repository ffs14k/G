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
        
        /// G Table Example
        
        let tableExampleView = GTableExampleViewController()
        let tableExampleViewModel = GTableExampleViewModel()
        
        tableExampleView.viewModel = tableExampleViewModel
        tableExampleViewModel.view = tableExampleView
        
        tableExampleView.tabBarItem = UITabBarItem(title: "Table", image: nil, selectedImage: nil)
        
        
        // G Collection example
        
        let collectionExampleView = GCollectionExampleViewController()
        let collectionExampleViewModel = GCollectionExampleViewModel()
        
        collectionExampleView.viewModel = collectionExampleViewModel
        collectionExampleViewModel.view = collectionExampleView
         
        collectionExampleView.tabBarItem = UITabBarItem(title: "Collection", image: nil, selectedImage: nil)
        
        
        // Tabs
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            tableExampleView,
            collectionExampleView
        ]
        
        return tabBar
    }

}

