//
//  NqwlPageCollectionView.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/4/9.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

protocol NqwlPageCollectionViewDataSource : class {
    func numberOfSections(in pageCollectionView : NqwlPageCollectionView) -> Int
    func pageCollectionView(_ collectionView: NqwlPageCollectionView, numberOfItemsInSection section: Int) -> Int
    func pageCollectionView(_ pageCollectionView : NqwlPageCollectionView ,_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class NqwlPageCollectionView: UIView {

    weak var dataSource : NqwlPageCollectionViewDataSource?

    fileprivate var titles : [String]
    fileprivate var isTitleInTop : Bool
    fileprivate var style : NqwlTitleStyle
    fileprivate var layout : NqwlPageCollectionViewLaout
    fileprivate var collectionView : UICollectionView!
    fileprivate var pageControl : UIPageControl!
    fileprivate var titleView : NqwlTitleView!
    fileprivate var sourceIndexPath : IndexPath = IndexPath(item: 0, section: 0)

    init(frame: CGRect, titles : [String], style : NqwlTitleStyle, isTitleInTop : Bool, layout : NqwlPageCollectionViewLaout) {
        self.titles = titles
        self.style = style
        self.isTitleInTop = isTitleInTop
        self.layout = layout

        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK:- 设置UI界面
extension NqwlPageCollectionView {
    fileprivate func setupUI() {

        // 1.创建titleView
        let titleY = isTitleInTop ? 0 : bounds.height - style.titleHeight
        let titleFrame = CGRect(x: 0, y: titleY, width: bounds.width, height: style.titleHeight)
        titleView = NqwlTitleView(frame: titleFrame, titles: titles, style: style)
        addSubview(titleView)
        titleView.delegate = self
        titleView.backgroundColor = UIColor.white

        // 2.创建UIPageControl
        let pageControlHeight : CGFloat = 20
        let pageControlY = isTitleInTop ? (bounds.height - pageControlHeight) : (bounds.height - pageControlHeight - style.titleHeight)
        let pageControlFrame = CGRect(x: 0, y: pageControlY, width: bounds.width, height: pageControlHeight)
        pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 4
        pageControl.isEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.init(r: 122, g: 122, b: 122)
        addSubview(pageControl)

        // 3.创建UICollectionView
        let collectionViewY = isTitleInTop ? style.titleHeight : 0
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: bounds.width, height: bounds.height - style.titleHeight - pageControlHeight)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        pageControl.backgroundColor = collectionView.backgroundColor
        addSubview(collectionView)
    }
}


// MARK:- 对外暴露的方法
extension NqwlPageCollectionView {
    func register(cell : AnyClass?, identifier : String) {
        collectionView.register(cell, forCellWithReuseIdentifier: identifier)
    }

    func register(nib : UINib, identifier : String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}


// MARK:- UICollectionViewDataSource
extension NqwlPageCollectionView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: section) ?? 0

        if section == 0 {
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1
        }

        return itemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.pageCollectionView(self, collectionView, cellForItemAt: indexPath)
    }

}


// MARK:- UICollectionViewDelegate
extension NqwlPageCollectionView : UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewEndScroll()
        }
    }

    fileprivate func scrollViewEndScroll() {
        // 1.取出在屏幕中显示的Cell
        let point = CGPoint(x: layout.sectionInset.left + 1 + collectionView.contentOffset.x, y: layout.sectionInset.top + 1)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }

        // 2.判断分组是否有发生改变
        if sourceIndexPath.section != indexPath.section {
            // 3.1.修改pageControl的个数
            let itemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: indexPath.section) ?? 0
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1

            // 3.2.设置titleView位置
            titleView.setTitleWithProgress(1.0, sourceIndex: sourceIndexPath.section, targetIndex: indexPath.section)

            // 3.3.记录最新indexPath
            sourceIndexPath = indexPath
        }

        // 3.根据indexPath设置pageControl
        pageControl.currentPage = indexPath.item / (layout.cols * layout.rows)
    }
}


// MARK:- HYTitleViewDelegate
extension NqwlPageCollectionView : NqwlTitleViewDelegate {
    func titleView(_ titleView: NqwlTitleView, selectedIndex index: Int) {
        let indexPath = IndexPath(item: 0, section: index)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        collectionView.contentOffset.x -= layout.sectionInset.left

        scrollViewEndScroll()
    }
}
