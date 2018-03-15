//
//  MeViewController.swift
//  IOS11Demo
//
//  Created by 623971951 on 2018/3/14.
//  Copyright © 2018年 syc. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    private var tabView: UITableView!
    private let cellId = "cell_identifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "我的"
        self.view.backgroundColor = UIColor.white
        
        tabView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tabView.delegate = self
        tabView.dataSource = self
        self.view.addSubview(tabView)
        
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MeViewController: UITableViewDataSource{
    // MARK: data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "row: \(indexPath.row)"
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section: \(section)"
    }
}
extension MeViewController: UITableViewDelegate{
    // MARK: delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
