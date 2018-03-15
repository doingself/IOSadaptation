//
//  TabBarViewController.swift
//  IOS11Demo
//
//  Created by 623971951 on 2018/3/14.
//  Copyright © 2018年 syc. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tabbaritemHome = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 1)
        let home = HomeViewController()
        let navHome = UINavigationController(rootViewController: home)
        navHome.tabBarItem = tabbaritemHome
        
        let find = FindViewController()
        find.tabBarItem.title = "发现"
        
        let me = MeViewController()
        let navMe = UINavigationController(rootViewController: me)
        navMe.tabBarItem.title = "我的"
        
        UITabBar.appearance().tintColor = UIColor.orange
        
        self.viewControllers = [navHome, find, navMe]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
