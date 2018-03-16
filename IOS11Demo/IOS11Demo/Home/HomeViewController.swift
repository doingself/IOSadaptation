//
//  HomeViewController.swift
//  IOS11Demo
//
//  Created by 623971951 on 2018/3/14.
//  Copyright © 2018年 syc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var tabView: UITableView!
    private let cellId = "cell_identifier"
    private let datas: [String] = {
        let arr = [
            "UINavigationBar 新增prefersLargeTitles 大标题，默认为false",
            "UINavigationItem 新增largeTitleDisplayMode属性 当UINavigationBar.prefersLargeTitles=true 才生效, largeTitleDisplayMode控制某个单独的ViewController中是否显示大标题",
            "UINavigationItem 新增searchController属性 在navigation bar下面增加一个搜索框 `navigationItem.searchController = UISearchController()`",
            "UINavigationItem 新增hidesSearchBarWhenScrolling属性,配合searchController使用的，默认是true,下拉才会显示搜索框",
            "UITableView 新增separatorInsetReference属性分割线相关的",
            "UITableViewDelegate 新增了两个delegate, 主要是实现了TableViewCell的左划和右划手势功能, 为了取代原有的editActionsForRowAtIndexPath",
            "1111111111",
        ]
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "首页"
        self.view.backgroundColor = UIColor.white
        
        // MARK: IOS11 new features
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //self.navigationItem.largeTitleDisplayMode = .automatic // prefersLargeTitles=true才生效
        
        // MARK: search
        let search = UISearchController(searchResultsController: ViewController())
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = true //依赖 searchController
        
        // MARK: tab
        tabView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        tabView.delegate = self
        tabView.dataSource = self
        self.view.addSubview(tabView)
        
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tabView.separatorInsetReference = UITableViewSeparatorInsetReference.fromAutomaticInsets
        
        tabView.rowHeight = UITableViewAutomaticDimension
        tabView.estimatedRowHeight = 44.0
        tabView.estimatedSectionHeaderHeight = 0
        tabView.estimatedSectionFooterHeight = 0
        
        // refresh
        let ref = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        tabView.refreshControl = ref
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController: UITableViewDataSource{
    // MARK: data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = datas[indexPath.row]
        cell.detailTextLabel?.text = "row:\(indexPath.row)"
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section: \(section)"
    }
}
extension HomeViewController: UITableViewDelegate{
    // MARK: delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let v = HomeChildLandscapeViewController()
        if indexPath.row % 2 == 0{
            self.navigationController?.pushViewController(v, animated: true)
        }else{
            self.present(v, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let normalAction = UIContextualAction(style: UIContextualAction.Style.normal, title: "normal") { (act: UIContextualAction, v: UIView, handler) in
            print("normal action")
        }
        let destructiveAction = UIContextualAction(style: UIContextualAction.Style.destructive, title: "destructive") { (act: UIContextualAction, v: UIView, handler) in
            print("destructive action")
        }
        let customAction = UIContextualAction(style: UIContextualAction.Style.normal, title: "custom") { (act: UIContextualAction, v: UIView, handler) in
            print("custom action")
        }
        customAction.backgroundColor = UIColor.blue
        //customAction.image
        let swipe = UISwipeActionsConfiguration(actions: [normalAction, destructiveAction, customAction])
        return swipe
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let normalAction = UIContextualAction(style: UIContextualAction.Style.normal, title: "右侧") { (act: UIContextualAction, v: UIView, handler) in
            print("normal action")
        }
        let destructiveAction = UIContextualAction(style: UIContextualAction.Style.destructive, title: "右删") { (act: UIContextualAction, v: UIView, handler) in
            print("destructive action")
        }
        let swipe = UISwipeActionsConfiguration(actions: [destructiveAction,normalAction])
        return swipe
    }
}

