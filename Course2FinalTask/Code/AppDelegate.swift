//
//  AppDelegate.swift
//  Course2FinalTask
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let tabBarController = UITabBarController()
        
        let feedController = FeedViewController()
        let profileController = ProfileViewController()
        let feedNavgationController = MainNavigationController()
        let profileNavgationController = MainNavigationController()
        
        feedNavgationController.viewControllers = [feedController]
        profileNavgationController.viewControllers = [profileController]
        
        feedNavgationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed"), tag: 0)
        profileNavgationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 1)
        
        tabBarController.viewControllers = [feedNavgationController, profileNavgationController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController

        return true
    }
}
