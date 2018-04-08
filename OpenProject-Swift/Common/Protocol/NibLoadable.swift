//
//  NibLoadable.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/26.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit
protocol NibLoadable {

}
extension NibLoadable where Self : UIView {
    //结构体、枚举、协议里面定义类方法只能用static修饰
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname
        return Bundle.main.loadNibNamed(loadName!, owner: nil, options: nil)?.first as! Self
    }
}
