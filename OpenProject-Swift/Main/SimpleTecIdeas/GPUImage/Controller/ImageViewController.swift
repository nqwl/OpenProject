//
//  ImageViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/4/16.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit
enum GPUImageShow {
    case GPUImageShowOne
    case GPUImageShowTwo
    case GPUImageShowThree
    case GPUImageShowFour
}

class ImageViewController: UIViewController {
    var showType : GPUImageShow = GPUImageShow.GPUImageShowOne

    @IBOutlet weak var showImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        switch showType {
        case GPUImageShow.GPUImageShowOne:
            self.blurImage()
        case GPUImageShow.GPUImageShowTwo:
            self.blurImage()
        case GPUImageShow.GPUImageShowThree:
            self.blurImage()
        case GPUImageShow.GPUImageShowFour:
            self.blurImage()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ImageViewController {
    fileprivate func blurImage() {

    }
}








