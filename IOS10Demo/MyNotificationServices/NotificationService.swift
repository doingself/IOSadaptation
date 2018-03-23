//
//  NotificationService.swift
//  MyNotificationServices
//
//  Created by 623971951 on 2018/3/23.
//  Copyright © 2018年 syc. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    /**
     该方法中有一个等待发送的通知请求。
     我们通过修改这个请求中的 content 内容，然后在限制的时间内将修改后的内容通过调用 contentHandler 返还给系统，就可以显示这个修改过的通知了。
     */
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [只针对远程通知,对通知标题做了修改]"
            
            contentHandler(bestAttemptContent)
        }
    }
    
    /*
    serviceExtensionTimeWillExpire
    在一定时间内如果没有调用 contentHandler 的话，系统会调用这个方法，来告诉我们时间到了：
    我们可以什么都不做，这样的话系统便当作什么都没发生，简单地显示原来的通知。
    或许我们已经设置好了绝大部分内容，只是有很少一部分没有完成。这时我们也可以像例子中这样调用 contentHandler 来显示一个变更到一半的通知。
    原文出自：www.hangge.com  转载请保留原文链接：http://www.hangge.com/blog/cache/detail_1852.html
    */
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
