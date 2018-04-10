//
//  EmotionViewModel.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/4/10.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class EmotionViewModel {
    static let shareInstance : EmotionViewModel = EmotionViewModel()
    lazy var packages = [NSArray]()
    init() {
        let emotionBundle = kFindeNSBunld(bundleName: "XEmotionIcons")
        let qqPath = "\(emotionBundle)/QQEmotion/QQEmtion.plist"
        let qqEmtionArr : [NSDictionary] = NSArray.init(contentsOfFile: qqPath) as! [NSDictionary]
        let qqModelArray = NSMutableArray()
        let lxhModelArray = NSMutableArray()
        for item in qqEmtionArr {
            if let model = QQEmotionModel.deserialize(from: item) {
                qqModelArray.add(model)
            }
        }
        let lxhPath = "\(emotionBundle)/lxh/info.plist"
        let lxhEmtionArr : [NSDictionary] = NSArray.init(contentsOfFile: lxhPath) as! [NSDictionary]
        for item in lxhEmtionArr {
            let model = LXHEmotionModel.deserialize(from: item as? Dictionary)
            lxhModelArray.add(model!)
        }
        self.packages.append(qqModelArray)
        self.packages.append(lxhModelArray)
    }
}
extension EmotionViewModel {

}
