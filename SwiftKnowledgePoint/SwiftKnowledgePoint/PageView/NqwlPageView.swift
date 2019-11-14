//
//  NqwlPageView.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/27.
//  Copyright © 2018年 陈辉. All rights reserved.
//


import UIKit

class NqwlPageView: UIView {

    // MARK: 定义属性
    fileprivate var titles : [String]!
    fileprivate var style : NqwlTitleStyle!
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!

    fileprivate var titleView : NqwlTitleView!
    var contentView : NqwlContentView!

    // MARK: 自定义构造函数
    init(frame: CGRect, titles : [String], style : NqwlTitleStyle, childVcs : [UIViewController], parentVc : UIViewController) {
        super.init(frame: frame)

        assert(titles.count == childVcs.count, "标题&控制器个数不同,请检测!!!")
        self.style = style
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        if #available(iOS 11.0,*) {
        }else {
            parentVc.automaticallyAdjustsScrollViewInsets = false
        }


        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置界面内容
extension NqwlPageView {
    fileprivate func setupUI() {
        let titleH : CGFloat = 44
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView = NqwlTitleView(frame: titleFrame, titles: titles, style : style)
        titleView.delegate = self
        addSubview(titleView)

        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = NqwlContentView(frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
    }
}


// MARK:- 设置NqwlContentView的代理
extension NqwlPageView : NqwlContentViewDelegate {
    func contentView(_ contentView: NqwlContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }

    func contentViewEndScroll(_ contentView: NqwlContentView) {
        titleView.contentViewDidEndScroll()
    }
}


// MARK:- 设置NqwlTitleView的代理
extension NqwlPageView : NqwlTitleViewDelegate {
    func titleView(_ titleView: NqwlTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}
