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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        
    }
    
    // 收到通知
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        
        let content = notification.request.content
        
    }
    // 点击了 action 按钮
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        
        print("\(#function) response.actionid = \(response.actionIdentifier)")
        
        completion(UNNotificationContentExtensionResponseOption.doNotDismiss)
    }

}
