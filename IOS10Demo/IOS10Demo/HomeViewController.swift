//
//  HomeViewController.swift
//  IOS10Demo
//
//  Created by 623971951 on 2018/3/20.
//  Copyright © 2018年 syc. All rights reserved.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {

    private var tabView: UITableView!
    private let cellId = "cellIdentifier"
    private lazy var datas: [String] = {
        let arr = [
            "获取通知权限,并申请",
            "打印通知权限",
            "点击后,5秒显示通知",
            "点击后,在固定时间显示通知"
        ]
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "home"
        self.view.backgroundColor = UIColor.white
        
        tabView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        tabView.delegate = self
        tabView.dataSource = self
        self.view.addSubview(tabView)
        
        tabView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        tabView.estimatedRowHeight = 44.0
        tabView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 屏幕旋转后适配 , 也可以使用 override func viewDidLayoutSubviews()
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        print("\(#function) + \(self.view.frame.size) + \(size) + \(coordinator.transitionDuration)")
        UIView.animate(withDuration: coordinator.transitionDuration) {
            self.tabView.frame.size = size
        }
    }
}

extension HomeViewController: UITableViewDataSource{
    // MARK: tab data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        cell.setData(str: datas[indexPath.row])
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
extension HomeViewController: UITableViewDelegate{
    // MARK: tab delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            self.getNotificationSet()
        case 1:
            self.printNotificationSet()
        case 2:
            self.addLocalNotification()
        default:
            break
        }
    }
}

extension HomeViewController{
    // MARK: UNUserNotification
    
    /// 在固定时间显示通知(闹钟)
    func addLocalNotificationAtTime(){
        // 内容
        let content = UNMutableNotificationContent()
        content.title = "这是标题"
        content.subtitle = "固定时间显示通知 subtitle"
        content.body = "固定时间显示通知 body"
        content.badge = 4
        
        // 指定日期
        var components = DateComponents()
//        components.year = 2018
//        components.month = 3
//        components.day = 21
        //components.weekday = 4 // 周三
//        components.hour = 15
        components.second = 10
        
        // 触发器
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        // 通知请求
        let requestIdentifier = "identifier"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 添加通知
        UNUserNotificationCenter.current().add(request) { (err: Error?) in
            if let e = err{
                print("notification add error : \(e)")
            }
        }
    }
    /// 添加一个本地通知
    func addLocalNotification(){
        // 内容
        let content = UNMutableNotificationContent()
        content.title = "这是标题"
        content.subtitle = "5秒后显示通知 subtitle"
        content.body = "5秒后显示通知 body"
        content.badge = 4
        
        // 触发器, 5秒后触发
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        // 通知请求
        let requestIdentifier = "identifier"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 添加通知
        UNUserNotificationCenter.current().add(request) { (err: Error?) in
            if let e = err{
                print("notification add error : \(e)")
            }
        }
    }
    /// 查看权限,并申请
    func getNotificationSet(){
        UNUserNotificationCenter.current().getNotificationSettings { (sets: UNNotificationSettings) in
            // 查看当前权限
            switch sets.authorizationStatus{
            case UNAuthorizationStatus.authorized:
                // 允许
                return
            case .notDetermined:
                // 申请通知权限
                UNUserNotificationCenter.current().requestAuthorization(options: [UNAuthorizationOptions.alert,.sound]) { (b: Bool, err: Error?) in
                    if b == false{
                        print("不允许通知")
                    }
                }
            case .denied:
                // 不允许
                DispatchQueue.main.async(execute: {
                    let alertController = UIAlertController(title: "提示", message: "没有通知权限", preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
                    let setAction = UIAlertAction(title: "设置", style: UIAlertActionStyle.destructive, handler: { (alert: UIAlertAction) in
                        let url = URL(string: UIApplicationOpenSettingsURLString)
                        UIApplication.shared.open(url!, options: [:], completionHandler: { (suc: Bool) in
                        })
                    })
                    alertController.addAction(cancelAction)
                    alertController.addAction(setAction)
                    self.present(alertController, animated: true, completion: nil)
                })
            }
        }
    }
    /// 查看权限
    func printNotificationSet(){
        UNUserNotificationCenter.current().getNotificationSettings {
            settings in
            var message = "是否允许通知："
            switch settings.authorizationStatus {
            case .authorized:
                message.append("允许")
            case .notDetermined:
                message.append("未确定")
            case .denied:
                message.append("不允许")
            }
            
            message.append("\n\t声音：")
            switch settings.soundSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n\t应用图标标记：")
            switch settings.badgeSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n\t在锁定屏幕上显示：")
            switch settings.lockScreenSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n\t在历史记录中显示：")
            switch settings.notificationCenterSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n\t横幅显示：")
            switch settings.alertSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            if #available(iOS 11.0, *) {
                message.append("\n\t显示预览：")
                switch settings.showPreviewsSetting{
                case .always:
                    message.append("始终（默认）")
                case .whenAuthenticated:
                    message.append("解锁时")
                case .never:
                    message.append("从不")
                }
            }
            
            print(message)
        }
    }
}
