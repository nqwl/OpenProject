//
//  NBaseNavViewController.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2020/1/2.
//  Copyright © 2020 Nqwl. All rights reserved.
//

import UIKit

class NBaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
       override var shouldAutorotate: Bool {
         self.topViewController?.shouldAutorotate ?? false
     }
     override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
         self.topViewController?.supportedInterfaceOrientations ?? .portrait
     }
     override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
         self.topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
     }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {

        super.popToViewController(viewController, animated: animated)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
