//
//  ImageFrame.swift
//  播放Gif图片
//
//  Created by apple on 16/12/14.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class ImageFrame {
    var image : UIImage
    var duration : TimeInterval
    
    init(image : UIImage, duration : TimeInterval) {
        self.image = image
        self.duration = duration
    }
}
