//
//  NotificationViewController.swift
//  MyNotificationContent
//
//  Created by 623971951 on 2018/3/23.
//  Copyright © 2018年 syc. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet weak var imgView: UIImageView!
    
    private var items: [String] = []
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        
    }
    
    // 收到通知
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        self.imgView.image = UIImage(named: "notificeImg")
        
        let content = notification.request.content
        if let kkk = content.userInfo["mykey"] as? [String] {
            items = kkk
        }
    }
    private func showIndex(i: Int){
        index = i
        let item = items[index]
        self.label?.text = item
        /*
        //更新图片
        if item.url.startAccessingSecurityScopedResource() {
            self.imageView.image = UIImage(contentsOfFile: item.url.path)
            item.url.stopAccessingSecurityScopedResource()
        }
        */
    }
    // 点击了 action 按钮(注册的 category)
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        
        print("\(#function) response.actionid = \(response.actionIdentifier)")
        
        if response.actionIdentifier == "change"{
            let nextIndex = (index + 1) % items.count
            showIndex(i: nextIndex)
            
            // 保持通知继续显示
            completion(.doNotDismiss)
            
        }else if response.actionIdentifier == "foregroundBtn"{
            // diss 并 打开
            completion(UNNotificationContentExtensionResponseOption.dismissAndForwardAction)
            
        }else if response.actionIdentifier == "destructiveBtn"{
            // 关闭通知
            completion(.dismiss)
        }
    }
}
