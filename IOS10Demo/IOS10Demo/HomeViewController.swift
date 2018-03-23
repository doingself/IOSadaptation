//
//  HomeViewController.swift
//  IOS10Demo
//
//  Created by 623971951 on 2018/3/20.
//  Copyright © 2018年 syc. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class HomeViewController: UIViewController {

    private var tabView: UITableView!
    private let cellId = "cellIdentifier"
    private lazy var datas: [String] = {
        let arr = [
            "获取通知权限,并申请",
            "打印通知权限",
            "点击后,5秒显示通知",
            "点击后,在固定时间显示通知",
            "点击后,在固定位置(经纬度)显示通知",
            "打印所有通知(远程+本地)",
            "打印已经推送的通知",
            "删除通知",
            
            "添加通知代理",
            "点击后,3秒显示有交互的通知,基于代理",
            "注册category,基于代理"
            
        ]
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "UNUserNotification(本地/远程通知)"
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
            self.tabView.reloadData()
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
        cell.setData(str: "\(indexPath.row). "+datas[indexPath.row])
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
        
        let isTest = false
        if isTest && indexPath.row > 0 {
            return
        }
        
        switch indexPath.row {
        case 0:
            // 申请
            self.getNotificationSet()
        case 1:
            // 打印通知权限
            self.printNotificationSet()
        case 2:
            // 5秒后显示通知
            self.addLocalNotification()
        case 3:
            // 固定时间显示通知
            self.addLocalNotificationAtTime()
        case 4:
            // 根据经纬度显示通知
            self.addLocalNotificationAtLocation()
        case 5:
            // 打印所有通知
            self.showAllNotification()
        case 6:
            // 打印已经推送的通知
            self.showPushNotification()
        case 7:
            // 删除通知
            self.removeNotification()
        case 8:
            // 代理
            self.addDelegate()
        case 9:
            // 显示交互的通知(action)
            self.addLocalNotificationAtAction()
        case 10:
            // 注册 category
            registerNotificationCategory()
            
        default:
            break
        }
    }
}

extension HomeViewController: UNUserNotificationCenterDelegate{
    // MARK: UNUserNotification delegate 通知代理
    
    // 默认情况下当应用处于前台时，收到的通知是不进行展示的。
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("willPresent \(notification.request.content.body)")
        //在应用内展示通知
        completionHandler([UNNotificationPresentationOptions.alert, .sound])
    }
    
    // 用户与通知进行交互时被调用
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // 通知的信息
        print("didReceive ", response.notification.request.content.body)
        print("didReceive ", response.notification.request.content.userInfo)
        
        let categoryIdentifier = response.notification.request.content.categoryIdentifier
        if categoryIdentifier == "myCategoryIdentifier"{
            let actionType = response.actionIdentifier
            let msg: String
            if actionType == "txtInputNotifAct" {
                msg = "输入了 === " + (response as! UNTextInputNotificationResponse).userText
            }else{
                msg = "点击了 === " + actionType
            }
            
            print("didReceive ", categoryIdentifier)
            print("didReceive ", actionType)
            
            if let vc = UIApplication.shared.keyWindow?.rootViewController{
                let alert = UIAlertController(title: "action", message: msg, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(action)
                vc.present(alert, animated: true, completion: nil)
            }
        }
        //完成了工作
        completionHandler()
    }
}

extension HomeViewController{
    // MARK: UNUserNotification 自定义通知
    
    /// 注册 category
    func registerNotificationCategory(){
        let myCategory: UNNotificationCategory = {
            // 输入框 action
            let inputAction = UNTextInputNotificationAction(identifier: "txtInputNotifAct", title: "文本框", options: UNNotificationActionOptions.foreground, textInputButtonTitle: "btn", textInputPlaceholder: "placeholder..")
            
            // 按钮 action
            let btnAction = UNNotificationAction(identifier: "foregroundBtn", title: "foreground按钮", options: UNNotificationActionOptions.foreground)
            
            let cancelBtnAction = UNNotificationAction(identifier: "destructiveBtn", title: "destructive按钮", options: UNNotificationActionOptions.destructive)
            
            // category
            let myCategory: UNNotificationCategory = UNNotificationCategory(
                identifier: "myCategoryIdentifier",
                actions: [inputAction, btnAction, cancelBtnAction],
                intentIdentifiers: [],
                options: UNNotificationCategoryOptions.customDismissAction
            )
            return myCategory
        }()
        // 添加到 center
        UNUserNotificationCenter.current().setNotificationCategories([myCategory])
    }
    /// 添加有交互的通知
    func addLocalNotificationAtAction(){
        // 内容
        let content = UNMutableNotificationContent()
        content.title = "这是标题"
        content.body = "3秒后显示交互通知 body"
        content.categoryIdentifier = "myCategoryIdentifier"
        
        // 触发器, 3秒后触发
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        // 多次推送同一标识符的通知, 原先的那条通知就会被替换
        let requestIdentifier = "identifier3Second"
        // 通知请求
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 添加通知
        UNUserNotificationCenter.current().add(request) { (err: Error?) in
            if let e = err{
                print("notification add error : \(e)")
            }
        }
    }
    
    /// 添加通知代理
    func addDelegate(){
        UNUserNotificationCenter.current().delegate = self
    }
    /// 删除通知
    func removeNotification(){
        // 未推送的通知
        // 根据 标识符 删除 未推送的通知
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["notificationId"])
        // 删除 未推送的通知
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // 已经推送的通知(从通知中心删除)
        // 根据 标识符 删除 已经推送的通知
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["notificationId"])
        // 删除 已经推送的通知
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
    }
    /// 打印已经推送的通知
    func showPushNotification(){
        UNUserNotificationCenter.current().getDeliveredNotifications { (notifications: [UNNotification]) in
            for notification in notifications{
                print("推送过的通知: ", notification.request.content.body)
            }
        }
    }
    func showAllNotification(){
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests{
                print("所有通知: ", request.content.body)
            }
        }
    }
    /// 在 固定位置(经纬度) 显示通知
    func addLocalNotificationAtLocation(){
        // 内容
        let content = UNMutableNotificationContent()
        content.title = "这是标题"
        content.subtitle = "固定位置(经纬度) 显示通知 subtitle"
        content.body = "固定位置(经纬度) 显示通知 body"
        content.badge = 4
        
        // 位置
        let coordinate = CLLocationCoordinate2D(latitude: 39, longitude: 116)
        let region = CLCircularRegion(center: coordinate, radius: 500, identifier: "center")
        region.notifyOnExit = false // 离开不触发
        region.notifyOnEntry = true // 进入范围触发
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        // 通知请求
        let requestIdentifier = "identifierLocation"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 添加通知
        UNUserNotificationCenter.current().add(request) { (err: Error?) in
            if let e = err{
                print("notification add error : \(e)")
            }
        }
    }
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
        components.year = 2018
        components.month = 3
        components.day = 21
        components.weekday = 4 // 周三
        components.hour = 17
        components.minute = 12
        components.second = 0
        
        // 触发器
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        // 通知请求
        let requestIdentifier = "identifierTime"
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
        content.userInfo = ["kkk":"vvv", "haha": 123]
        
        // 触发器, 5秒后触发
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // 多次推送同一标识符的通知, 原先的那条通知就会被替换
        let requestIdentifier = "identifier5Second"
        // 通知请求
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


