//
//  Common.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/16.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

//////////////////////////////获取指定NSBundle下面的图片文件\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/// 找到指定的bundle
func kFindeNSBunld(bundleName : String) -> String {
    return Bundle.main.path(forResource: bundleName as String, ofType:"bundle")!
}
/// 找到bundle 文件夹下面对应的子文件
func kNSBunldInFile(bundleName : String,subPath : String) -> String {
    return "\(bundleName)/\(subPath)"
}
/// 获取指定路径图片文件
func kGetNSbunldImImage(bundleName : String,imageName : String) -> UIImage {
    return  UIImage.init(contentsOfFile: kNSBunldInFile(bundleName: bundleName, subPath: imageName) as String)!
}
/// 获取某个bundle的某个子文件下的某个图片
func kGETNSbunldINImage(bundleName : String,subPath:String,imageName : String) -> UIImage {
    return  kGetNSbunldImImage(bundleName: kNSBunldInFile(bundleName: kFindeNSBunld(bundleName: bundleName), subPath: subPath), imageName: imageName)
}


/// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
/// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
/// 适配iPhoneX
let is_iPhoneX = (kScreenH >= 812.0 ? true : false)
let kNavibarH: CGFloat = is_iPhoneX ? 88.0 : 64.0
let kTabbarH: CGFloat = is_iPhoneX ? 49.0+34.0 : 49.0
let kStatusbarH: CGFloat = is_iPhoneX ? 44.0 : 20.0
let iPhoneXBottomH: CGFloat = 34.0
let iPhoneXTopH: CGFloat = 24.0

/// 适配字体
let kChineseFontName = "Heiti SC"
func kChineseSystem (x : CGFloat) -> UIFont {
    return UIFont.init(name: kChineseFontName, size: x)!
}
func kAdaptedFontSize (x : CGFloat) -> UIFont {
    return kChineseSystem(x: x)
}
func kBoldSystem (x : CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: x)
}
func kAdaptedkBoldSystemFontSize (x : CGFloat) -> UIFont {
    return kBoldSystem(x: x)
}
//不同屏幕尺寸字体适配（320，568是因为效果图为IPHONE8 如果不是则根据实际情况修改）
let kScreenWidthRatio = kScreenW / 375.0
let kScreenHeightRatio = kScreenH / 667.0
func kAdaptedWidth (x : CGFloat) -> CGFloat {
    return ceil(x * kScreenWidthRatio)
}
func kAdaptedHeight (x : CGFloat) -> CGFloat {
    return ceil(x * kScreenHeightRatio)
}
//获取图片资源
func kGetImage (imageName : String) -> UIImage {
    return UIImage.init(named: imageName)!
}

// MARK:- 常量
struct MetricGlobal {
    static let padding: CGFloat = 10.0
    static let margin: CGFloat = 10.0
}

// MARK:- 颜色方法
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

// MARK:- 常用按钮颜色
// 颜色参考 http://www.sioe.cn/yingyong/yanse-rgb-16/
let kThemeMainColor = UIColor.init(hex: "0x920CDC")
let kThemeWhiteColor = UIColor.init(hex: "0xFFFFFF")
let kThemeWhiteSmokeColor = UIColor.init(hex: "0xFFFFFF")
let kThemeMistyRoseColor = UIColor.init(hex: "0xFFE4E1")  // 薄雾玫瑰
let kThemeGainsboroColor = UIColor.init(hex: "0xF3F4F5")  // 亮灰色
let kThemeOrangeRedColor = UIColor.init(hex: "0xFF4500")  // 橙红色
let kThemeLimeGreenColor = UIColor.init(hex: "0x32CD32")  // 酸橙绿
let kThemeSnowColor = UIColor.init(hex: "0xFFFAFA")
let kThemeLightGreyColor = UIColor.init(hex: "0xD3D3D3")
let kThemeGreyColor = UIColor.init(hex: "0xA9A9A9")
let kThemeTomatoColor = UIColor.init(hex: "0xF7583B")
let kThemeDimGrayColor = UIColor.init(hex: "0x696969")
let kThemeBlackColor = UIColor.init(hex: "0x000000")
let kThemeBackgroundColor = UIColor.init(hex: "0xF4F4F4")

// MARK:- 自定义打印方法
func CHLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))-\(message)")
    #endif
}


