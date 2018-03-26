//
//  KingfisherExtension.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/23.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ URLString : String? ,_ placeHolderName : String?) {
        guard let URLString = URLString else {
            return
        }
        guard let placeHolderName = placeHolderName else {
            return
        }
        guard let url = URL.init(string: URLString) else {
            return
        }
        kf.setImage(with: url, placeholder: UIImage.init(named: placeHolderName))
    }
}
