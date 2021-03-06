//
//  UIColor-Extension.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/14.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

extension UIColor {
    //在extension中给系统的类扩充构造函数，只能扩充‘便利构造函数’
    convenience init (r : CGFloat, g : CGFloat ,b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }

    convenience init? (hex : String, alpha : CGFloat = 1.0) {
        // 0xff0000
        guard hex.count >= 6 else {
            return nil
        }
        var tempHex = hex.uppercased()

        if tempHex.hasPrefix("0X"){
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        var range = NSMakeRange(0, 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        var r : UInt32 = 0, g :UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)

        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    class func getDeltaRGB(firstColor:UIColor,secondColor:UIColor) -> (CGFloat,CGFloat,CGFloat) {
        let firstCmps = firstColor.getRGB()
        let secondCmps = secondColor.getRGB()
        return (firstCmps.0 - secondCmps.0,firstCmps.1 - secondCmps.1,firstCmps.2 - secondCmps.2)
    }
    func getRGB() -> (CGFloat,CGFloat,CGFloat) {
        guard let cmps = cgColor.components else {
            fatalError("请通过rgb方式输入颜色")
        }
        return (cmps[0] * 255,cmps[1] * 255,cmps[2] * 255)
    }

}
