//
//  ViewController.swift
//  SceneDelegateDemo
//
//  Created by syc-ios on 2020/9/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Log(message: "")
        self.title = "title"
        self.navigationItem.title = "nav title"
        self.view.backgroundColor = UIColor.white
        
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTap(sender:))))
    }

}

extension ViewController {
    @objc func viewTap(sender: Any?){
        // 获取当前 window
        let windows = UIApplication.shared.windows
        for win in windows {
            Log(message: win)
        }
        
        if #available(iOS 13.0, *) {
            Log(message: UIApplication.shared.delegate)
            Log(message: self.view.window?.windowScene?.delegate)
            
            if let windowScenes = UIApplication.shared.connectedScenes as? Set<UIWindowScene> {
                for scene: UIWindowScene in windowScenes {
                    Log(message: scene.activationState)
                    Log(message: scene.windows.count)
                    Log(message: scene.windows.last)
                }
            }
            
        } else {
            Log(message: UIApplication.shared.keyWindow)
            Log(message: self.view.window)
            
        }
        
        // 获取当前显示的 VC
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
        } else {
            window = UIApplication.shared.keyWindow
        }
        Log(message: window?.rootViewController)
    }
}

