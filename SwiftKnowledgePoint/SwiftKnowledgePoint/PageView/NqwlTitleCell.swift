//
//  NqwlTitleCell.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/28.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class NqwlTitleCell: UICollectionViewCell {

    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomViewTop: NSLayoutConstraint!
    @IBOutlet weak var titleTop: NSLayoutConstraint!
    @IBOutlet weak var titleContentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
