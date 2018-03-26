//
//  Emitterable.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/26.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

protocol Emitterable {

}

extension Emitterable where Self : UIViewController {
    func startEmittering(imageString : String) {
        let leftEmitter : CAEmitterLayer = createEmitter(point: CGPoint(x: 100, y: -100),imageName: imageString)
        let rightEmitter : CAEmitterLayer = createEmitter(point: CGPoint(x: view.bounds.width * 0.5, y: -100),imageName: imageString)

        // 6.将发射器的layer添加到父layer中
        view.layer.addSublayer(leftEmitter)
        view.layer.addSublayer(rightEmitter)

    }
    func createEmitter(point : CGPoint, imageName : String) -> CAEmitterLayer {
        // 1.创建发射器
        let emitter = CAEmitterLayer()

        // 2.设置发射器的位置
        emitter.emitterPosition = point

        // 3.开启三维效果
        emitter.preservesDepth = true

        // 4.创建例子, 并且设置例子相关的属性
        // 4.1.创建例子Cell
        let cell = CAEmitterCell()

        // 4.2.设置粒子速度
        cell.velocity = 150
        cell.velocityRange = 100

        // 4.3.设置例子的大小
        cell.scale = 0.7
        cell.scaleRange = 0.3

        // 4.4.设置粒子方向
        cell.emissionLongitude = CGFloat(Double.pi / 2)
        cell.emissionRange = CGFloat(Double.pi / 4)

        // 4.5.设置例子的存活时间
        cell.lifetime = 6
        cell.lifetimeRange = 1.5

        // 4.6.设置粒子旋转
        cell.spin = CGFloat(Double.pi / 2)
        cell.spinRange = CGFloat(Double.pi / 4)

        // 4.6.设置例子每秒弹出的个数
        cell.birthRate = 20

        // 4.7.设置粒子展示的图片
        cell.contents = UIImage(named: imageName)?.cgImage

        // 5.将粒子设置到发射器中
        emitter.emitterCells = [cell]

        return emitter
    }
    func stopEmittering() {
        view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self)}).first?.removeFromSuperlayer()
        view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self)}).first?.removeFromSuperlayer()
    }
}
