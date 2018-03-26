//
//  CHBaseNavigationController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/6.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class CHBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //使用runtime，打印手势中所有属性
//        var count : UInt32 = 0
//        let ivas = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//            let nameP = ivar_getName(ivas[Int(i)])!
//            let name = String.init(cString: nameP)
//            print(name)
//        }
        guard  let  targets = interactivePopGestureRecognizer?.value(forKey: "_targets") as? [NSObject] else { return }
        let targetObj = targets[0]
        print(targetObj)
        let target = targetObj.value(forKey: "target")
        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer.init(target: target , action:action)
        view.addGestureRecognizer(panGes)

        // 设置导航栏样式
        navigationBar.setBackgroundImage(UIImage.color(kThemeWhiteColor!), for: UIBarPosition.any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()

        // 标题样式
        let bar = UINavigationBar.appearance()
        bar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.black,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
        ]

        // 设置返回按钮的样式
        navigationBar.tintColor = kThemeBlackColor  // 设置返回标识器的颜色
        let barItem = UIBarButtonItem.appearance()
        barItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : kThemeBlackColor!], for: .normal)  // 返回按钮文字样式
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
        viewController.hidesBottomBarWhenPushed = false
    }

}

// MARK:- 事件 (部分页面失效)
extension CHBaseNavigationController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // 注销 键盘
        view.endEditing(true)
    }
}

