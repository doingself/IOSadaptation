//
//  HomeTableViewCell.swift
//  IOS10Demo
//
//  Created by 623971951 on 2018/3/21.
//  Copyright © 2018年 syc. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lab1.numberOfLines = 0
        lab2.numberOfLines = 0
        
        lab1.layer.borderWidth = 1
        lab2.layer.borderWidth = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 屏幕旋转后屏幕适配
    override func layoutSubviews() {
        super.layoutSubviews()
        print("\(#function)")
    }
    func setData(str: String?){
        lab1.text = str
        lab2.text = str
    }
}
