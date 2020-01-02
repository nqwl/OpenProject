//
//  NTabBarVC.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2020/1/2.
//  Copyright © 2020 Nqwl. All rights reserved.
//

import UIKit

class NTabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        createChildController()
    }
    /// 通过自定义方法添加所有子控制器
    func createChildController() {
        addChildVC(childVc: NHomeViewController(), title: "首页", image: "tab_home", selectedImage: "tab_home_sel")
        addChildVC(childVc: ViewController(), title: "我的", image: "tab_me", selectedImage: "tab_me_sel")

    }

    /// 自定义添加子控制器
    func addChildVC(childVc: UIViewController, title:String, image: String, selectedImage: String) {
        let nav = NBaseNavViewController(rootViewController: childVc)
        let normalImage = UIImage(named: image)
        let selectedImage = UIImage(named: selectedImage)
        nav.navigationItem.title = title
        nav.tabBarItem = tabbarItem(with: title, normalImage: normalImage!, selectedImage: selectedImage!)
        addChild(nav)
    }

    /// 快捷创建 UITabBarItem
    func tabbarItem(with title: String, normalImage: UIImage, selectedImage: UIImage) -> UITabBarItem{
        let image = normalImage.withRenderingMode(.alwaysOriginal)
        let _selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: _selectedImage)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kThemeMainColor!], for: .selected)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kThemeBlackColor!], for: .normal)
        return tabBarItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

