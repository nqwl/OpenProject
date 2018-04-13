//
//  UIself-NqwlGif.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/4/13.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit
import ImageIO

extension UIImageView {
    func setGif(gifName:String) {
        DispatchQueue.global().async {
            guard let filePath = Bundle.main.path(forResource: gifName, ofType: nil) else { return }
            guard let fileData = NSData(contentsOfFile: filePath) else { return }
            self.gifDeal(data: fileData)
        }
    }
    func setGif(gifUrl:String) {
        DispatchQueue.global().async {
            guard let fileData = NSData(contentsOf: URL.init(string: gifUrl)!) else { return }
            self.gifDeal(data: fileData)
        }
    }
    func stopGif() {
        self.stopAnimating()
    }
    
    fileprivate func gifDeal(data:NSData) {
        // 2.根据Data获取CGImageSource对象
        guard let imageSource = CGImageSourceCreateWithData(data, nil) else { return }
        // 3.获取gif图片中图片的个数
        let frameCount = CGImageSourceGetCount(imageSource)
        var duration : TimeInterval = 0
        var images = [UIImage]()
        for i in 0..<frameCount {

            // 3.1.获取图片
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            // 3.2.获取时长
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) , let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
                let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) else { continue }
            duration += frameDuration.doubleValue
            let image = UIImage(cgImage: cgImage)
            DispatchQueue.main.async {
                if i == 0 {
                    self.image = image
                }
            }
            images.append(image)
        }

        // 4.播放图片
        DispatchQueue.main.async {
            self.animationImages = images
            self.animationDuration = duration
            self.animationRepeatCount = 0
            self.startAnimating()
        }
    }
}
