//
//  AppDelegate.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2019/11/12.
//  Copyright © 2019 Nqwl. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = kThemeWhiteColor
        let tab = NTabBarVC.init()
        self.window?.rootViewController = tab
        self.window?.makeKeyAndVisible()
        return true
    }
}

