//
//  NqwlContentView.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/27.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit
/*
    self.不能省略的情况
    1> 在方法和其他的标识符有歧义(重名)
    2> 在闭包(block)中self.也不能省略
 */
protocol NqwlContentViewDelegate : class {
    func contentView(_ contentView : NqwlContentView,targetIndex:Int)
    func contentView(_ contentView : NqwlContentView,targetIndex:Int, progress:CGFloat)

}

private let kContentCellID = "NqwlContentCell"
class NqwlContentView: UIView {
    weak var delegate : NqwlContentViewDelegate?

    fileprivate var childVCs : [UIViewController]
    fileprivate var parentVC : UIViewController
    fileprivate var startOffsetX : CGFloat = 0

    fileprivate lazy  var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        //点击状态栏自动滚动到顶部，如果有n个(2个及以上)，那么这种自动滚动到顶部的效果就都不会出现，只有设置其中n-1个的scrollsToTop为false，才能实现剩下一个效果
        collectionView.scrollsToTop = false
        return collectionView
    }()
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension NqwlContentView {
    fileprivate func setupUI() {
        for childVC in childVCs {
            parentVC.addChildViewController(childVC)
        }
        addSubview(collectionView)
    }
}
// MARK:- collection view delegate
extension NqwlContentView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let childVC = self.childVCs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            contentEndScroll()
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard startOffsetX != scrollView.contentOffset.x else {
            return
        }
        var targetIndex = 0
        var progress : CGFloat = 0
        let currentIndex = Int(startOffsetX/scrollView.bounds.width)
        if startOffsetX < scrollView.contentOffset.x {
            //手指左滑动
            targetIndex = currentIndex + 1
            if targetIndex > (childVCs.count - 1) {
                targetIndex = (childVCs.count - 1)
            }
            progress = (scrollView.contentOffset.x - startOffsetX)/scrollView.bounds.width
        }else {
            //手指右滑动
            targetIndex = currentIndex - 1
            if targetIndex < 0 {
                targetIndex = 0
            }
            progress = (startOffsetX - scrollView.contentOffset.x)/scrollView.bounds.width
        }
        delegate?.contentView(self, targetIndex: targetIndex, progress: progress)
    }
    private func contentEndScroll() {
        let currentInde = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        delegate?.contentView(self, targetIndex: currentInde)
    }
}



// MARK:- 遵守NqwlTitleViewDelegate
extension NqwlContentView : NqwlTitleViewDelegate {
    func titleView(_ titleView: NqwlTitleView, tagetIndex: Int) {
        let indexPath = IndexPath(item: tagetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}
