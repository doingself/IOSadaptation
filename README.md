
官方提供的 [IOS 版本市场占有率](https://developer.apple.com/support/app-store/)

> IOS 10 28%  
> IOS 11 65%

第三方_DavidSmith提供的 [IOS 版本市场占有率](https://david-smith.org/iosversionstats/)

# IOS11 Demo

基于 IOS11 适配 iPhone X

# IOS 新特性

## IOS7 简单总结

IOS7最大的变化莫过于UI设计

## IOS 8 简单总结

1. App Extensions, Apple 允许我们在 app 中添加一个新的 target，用来提供一些扩展功能：比如在系统的通知中心中显示一个自己的 widget，在某些应用的 Action 中加入自己的操作，在分享按扭里加入自己的条目，更甚至于添加自定义的键盘等等	iOS上共有Today、Share、Action、Photo Editing、Storage Provider、Custom keyboard几种，其中Today中的extension又被称为widget。
2. autolayout自动布局和size classes布局
3. 不更改应用现有的数据模型和结构，而只是使用 Cloud Kit 来从云端获取数据或者向云端存储数据。(不夸平台)
4. Health Kit 是一个新的管理用户健康相关信息的框架
5. Home Kit 以家庭，房间和设备的组织形式来管理和控制家中适配了 Home Kit 的智能家电。
6. Touch ID
7. 新增加了 Photos.framework 框架，这个框架用于与系统内置的 Photo 应用进行交互，不仅可以替代原来的 Assets Library 作为照片和视频的选取，还能与 iCloud 照片流进行交互
8. Scene Kit(IOS 11 AR)
9. 新增AV Foundation Framework：在拍摄视频时可以获取视频的元数据，并嵌⼊⼀些信息。⽐如在摄像头录制视频时记录下物理位置信息
10. AVKit 框架以替代 Media Player 框架
11. UIKit Framework
	+ 使用本地或远程推送服务的app需要使用UIUserNofiticationSettings对象来明确的指明提示的类型。注册流程从注册远程推送服务的流程中分离祝来。而且需要用户同意。
	+ 推送可以执行app定义的操作。自定义的操作在提示中以按钮的形式显示。点击后，app会被通知然后执行相应的操作。本地通知也可以由位置信息驱动。
	+ Collection界面支持动态改变cell的大小。
	+ UISearchController类替代UISearchDisplayController来管理搜索相关的显示。
	+ UIViewController实现了traits以及新的计算大小的技术来调整内容。
	+ UISplitViewCOntroller可以在iPhone上支持了。
	+ UINavigationController有一些新的选项来改变navigation bar以及如何隐藏它。
	+ UIVisualEffect可以为界面增加模糊效果。
	+ UIPopoverPresentationController类处理popover中的内容。
	+ UIAlertController类替代UIActionSheet和UIAlertView类来显示提示信息。
	+ UIPrinterPickerController类提供一个显示打印机以及选择打印机的界面。打印机由UIPrinter类实例表示。
	+ 用户可以直接进入app相关的设置界面。

## IOS 9

1. Xcode7 免证书真机调试
2. iOS中bitcode是默认YES, enable bitcode 为 NO, bitcode的理解应该是把程序编译成的一种过渡代码，然后苹果再把这个过渡代码编译成可执行的程序。bitcode也允许苹果在后期重新优化我们程序的二进制文件，可以直接理解为APP瘦身。
3. App Transit Security，简称ATS，也就是我们所说的HTTP升级至HTTPS传输, 可以将NSAllowsArbitraryLoads设置为YES禁用ATS
4. URL scheme一般使用的场景是应用程序有分享或跳其他平台授权的功能，分享或授权后再跳回来,在外部调用的URL scheme列为白名单，才可以完成跳转.
5. 使用 Contacts 替代 Address Book; 使用 Contacts UI frameworks 替代 Address Book UI frameworks。
6. UIActionSheet和UIAlertView 过期, 用UIAlertController可以完全替代
7. statusBar 在vc中的 preferredStatusBarStyle 方法中返回样式

## IOS 10

1. SiriKit 所有第三方应用都可以用Siri，支持音频、视频、消息发送接收、搜索照片、预订行程、管理锻炼等
2. 自动管理证书
3. 所用到的隐私权限 强制必须在Info.plist中配置
4. 使用独立的UserNotifications.framework来集中管理和使用iOS系统中通知的功能。
5. 引入Speech.framework用来支持语音识别,在app中可以识别语音并转成文本,语音来源可以是实时的也可以是录音。
6. 推出了一个全新的API UIViewPropertyAnimator，可供我们处理动画操作
7. UIApplication对象中openUrl被废弃
8. 个性化定制 tabBarItem
9. 设置字体随系统变化动态调整大小 `adjustsFontForContentSizeCategory = YES`
10. 继承UIScrollView,都具有刷新的功能 `scrollView.refreshControl = UIRefreshControl()`
11. AVFoundation 中用 AVCapturePhotoOutput 替换 AVCaptureStillImageOutput
12. UIKit 中废弃了 UILocalNotification UIMutableUserNotificationAction UIMutableUserNotificationCategory UIUserNotificationAction UIUserNotificationCategory UIUserNotificationSettings
13. 2017年1月1日起苹果强制我们用HTTPS，可以通过NSExceptionDomains来针对特定的域名开放HTTP

## IOS 11

1. 新增负责简化和集成机器学习的 Core ML
2. 新增增强现实 (AR) 应用的 ARKit。
3. UINavigationBar 新增prefersLargeTitles 大标题，默认为false
4. UINavigationItem
	+ 新增largeTitleDisplayMode属性 当UINavigationBar.prefersLargeTitles=true 才生效, largeTitleDisplayMode控制某个单独的ViewController中是否显示大标题
	+ 新增searchController属性 在navigation bar下面增加一个搜索框 `navigationItem.searchController = UISearchController()`
	+ 新增hidesSearchBarWhenScrolling属性,配合searchController使用的，默认是true,下拉才会显示搜索框

5. UITableView 新增separatorInsetReference属性分割线相关的
6. UITableViewDelegate 新增了两个delegate, 主要是实现了TableViewCell的左划和右划手势功能, 为了取代原有的editActionsForRowAtIndexPath
7. UIViewController 弃用了automaticallyAdjustsScrollViewInsets属性, 这可能使得一些刷新出现头部错乱。
8. UIScrollView 新增contentInsetAdjustmentBehavior属性替代之前UIViewController的automaticallyAdjustsScrollViewInsets，contentInsetAdjustmentBehavior其实是一个枚举值, 根据某些情况自动调整scrollview的contentInset（实际改变的是adjustedContentInset属性，contentInset属性不会变）

# iPhone 机型适配

## iPhone 4 se 6 7 8 [plus]

## iphone x



# 屏幕旋转


# Requirements
+ Swift 4
+ iOS 10+
+ Xcode 9+

---

# 鸣谢

+ https://onevcat.com/2013/06/developer-should-know-about-ios7/
+ https://www.cnblogs.com/fengquanwang/p/3998526.html
+ https://www.jianshu.com/p/dd3475fb3960
+ https://www.jianshu.com/p/6780c4d58da3
+ https://www.jianshu.com/p/d4a17c32abdf
