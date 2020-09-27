//
//  AppDelegate.swift
//  SceneDelegateDemo
//
//  Created by syc-ios on 2020/9/27.
//

import UIKit

// 这里<T> 泛型 表示动态类型，传过来的是什么类型就是什么类型，<T>中的 T 只是一种写法 T 也可以被替换成任意字母或字符串
func Log<T>(message: T, file: String = #file, funcName: String = #function, lineNumber: Int = #line) {
    let fileName = (file as NSString).lastPathComponent
    print("\(fileName):(\(lineNumber)) - \(funcName) - \(message)")
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Log(message: "")
        
        if #available(iOS 13.0, *) {
            
        } else {
            let vc = ViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
}



@available(iOS 13.0, *)
extension AppDelegate {
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        Log(message: "")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
        Log(message: "")
    }


}

