//
//  AppDelegate.swift
//  IOS10Demo
//
//  Created by 623971951 on 2018/3/20.
//  Copyright © 2018年 syc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let home = HomeViewController()
        let navHome = UINavigationController(rootViewController: home)
        home.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 1)
        
        let find = FindViewController()
        let navFind = UINavigationController(rootViewController: find)
        navFind.tabBarItem = UITabBarItem(title: "find", image: nil, selectedImage: nil)
        
        let me = MeViewController()
        let navMe = UINavigationController(rootViewController: me)
        navMe.tabBarItem = UITabBarItem(title: "me", image: nil, selectedImage: nil)
        
        let tab = UITabBarController()
        tab.viewControllers = [navHome, navFind, navMe]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tab
        window?.makeKeyAndVisible()
        
        // MARK: 远程通知, 向 APNs 请求 token
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // token
        // Data ---> String
        let token = deviceToken.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: deviceToken.count)
            let res = buffer.map{ String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
            return res
        }
        print("token = \(token)")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

