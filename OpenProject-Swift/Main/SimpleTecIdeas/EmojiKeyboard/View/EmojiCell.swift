//
//  EmojiCell.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/4/9.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class EmojiCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!

    func configCellWithQQ(model:QQEmotionModel) {
        self.iconImageView.image = kGETNSbunldINImage(bundleName: "XEmotionIcons", subPath: "/QQEmotion/", imageName: model.png!)
    }
    func configCellWithLXH(model:LXHEmotionModel) {
        self.iconImageView.image = kGETNSbunldINImage(bundleName: "XEmotionIcons", subPath: "/lxh/", imageName:model.png!)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
