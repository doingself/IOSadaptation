//
//  HomeChildLandscapeViewController.swift
//  IOS11Demo
//
//  Created by 623971951 on 2018/3/16.
//  Copyright © 2018年 syc. All rights reserved.
//

import UIKit

class HomeChildLandscapeViewController: UIViewController {
    
    private var landscapeBtn: UIButton!
    private var portraitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "屏幕旋转"
        self.view.backgroundColor = UIColor.white
        
        // MARK: IOS11 new features
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic // prefersLargeTitles=true才生效
        
        landscapeBtn = UIButton(type: .custom)
        landscapeBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        landscapeBtn.setTitle("横屏", for: UIControlState.normal)
        landscapeBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        landscapeBtn.addTarget(self, action: #selector(self.landscape(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(landscapeBtn)
        
        portraitBtn = UIButton(type: .custom)
        portraitBtn.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        portraitBtn.setTitle("竖屏", for: UIControlState.normal)
        portraitBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        portraitBtn.addTarget(self, action: #selector(self.portrait(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(portraitBtn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.deviceOrientationDidChange(notif:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: 监听屏幕旋转
    @objc func deviceOrientationDidChange(notif: Notification){
        let orientation: UIDeviceOrientation = UIDevice.current.orientation
        print("当前设备方向: \(orientation.rawValue) \(orientation.hashValue)")
    }
    
    // MARK: 屏幕旋转
    /// 是否支持屏幕旋转
    override var shouldAutorotate: Bool{
        get{
            print("是否支持屏幕旋转")
            return true
        }
    }
    /// 支持的方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            print("屏幕旋转支持的方向")
            return UIInterfaceOrientationMask.allButUpsideDown
        }
    }
    /// 进入界面默认的方向(******* 仅present 有效 *********)
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get{
            print("进入界面默认的方向")
            return UIInterfaceOrientation.landscapeRight
        }
    }
    /// 监听屏幕旋转
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("屏幕旋转, 更新 UI")
    }
    
    /// 设置横屏
    @objc func landscape(sender: Any?){
        // 强制屏幕旋转, 与设备方向无关
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }
    /// 设置竖屏
    @objc func portrait(sender: Any?){
        // 强制屏幕旋转, 与设备方向无关
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
}
