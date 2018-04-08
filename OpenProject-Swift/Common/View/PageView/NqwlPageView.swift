//
//  NqwlPageView.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/27.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit


class NqwlPageView: UIView {

    fileprivate var titles : [String]
    fileprivate var childVCs : [UIViewController]
    fileprivate var parentVC : UIViewController
    fileprivate var style : NqwlTitleStyle

    init(frame: CGRect, titles: [String], childVCs: [UIViewController], parentVC: UIViewController ,style: NqwlTitleStyle) {
        self.titles = titles
        self.childVCs = childVCs
        self.parentVC = parentVC
        self.style = style
        super.init(frame: frame)
        setupUI()
    }
    //UIView只要有自定义构造函数必须父类的initWithCoder，此View以后不能从Xib和SB中加载了
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension NqwlPageView {
    fileprivate func setupUI() {

        let contentView = NqwlContentView.init(frame: CGRect(x: 0, y: style.titleHeight, width: bounds.size.width, height: bounds.size.height - style.titleHeight), childVCs:self.childVCs, parentVC:self.parentVC)
        addSubview(contentView)

        let  titleView = NqwlTitleView.init(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: style.titleHeight), titles: self.titles ,style:self.style)
        addSubview(titleView)
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}
