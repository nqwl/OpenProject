//
//  Animator.swift
//  播放Gif图片
//
//  Created by apple on 16/12/14.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit
import ImageIO

class Animator {
    fileprivate var imageSource : CGImageSource!  // imageSource 处理帧相关操作
    fileprivate var imageFrames : [ImageFrame] = [ImageFrame]() // 用于存放所有的帧
    fileprivate var frameCount : Int = 0
    fileprivate var currentIndex : Int = 0
    fileprivate var currentCacheIndex : Int = 0
    fileprivate var timeSinceLastFrameChange : TimeInterval = 0
    /// 循环次数
    fileprivate var loopCount = 0
}
