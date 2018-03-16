//
//  NqwlWaterFlowLayout.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/15.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

protocol NqwlWaterFlowLayoutDataSource : class {
    func numberOfCols(_ waterfallLaout : NqwlWaterFlowLayout) -> Int
    func waterfall(_ waterfallLaout : NqwlWaterFlowLayout, item : Int) -> CGFloat
}

class NqwlWaterFlowLayout: UICollectionViewFlowLayout {
    weak var dataSource : NqwlWaterFlowLayoutDataSource?
    fileprivate lazy var cellAttrs : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var cols : Int = {
        return self.dataSource?.numberOfCols(self) ?? 2
    }()
    fileprivate lazy var totalHeights : [CGFloat] = Array(repeatElement(sectionInset.top, count: cols))
    fileprivate var maxH : CGFloat = 0
    fileprivate var startIndex = 0

}

// MarK： - 准备布局
extension NqwlWaterFlowLayout {
    override func prepare() {
        super.prepare()
        //1、获取cell个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        //2、给每个cell创建一个UICollectionViewLayoutAttributes
        let cellW : CGFloat = (collectionView!.bounds.width - sectionInset.left  - sectionInset.right - (CGFloat(cols) - 1)*minimumLineSpacing)/CGFloat(cols)
        // 3.计算所有的item的属性
        for i in startIndex..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            guard let cellH : CGFloat = self.dataSource?.waterfall(self, item: i) else {
                fatalError("请实现对应的数据源方法，并返回cell的高度")
            }
            let minH = totalHeights.min()!
            let minIndex = totalHeights.index(of: minH)!
            let cellX : CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minIndex)
            let cellY : CGFloat = minH + minimumLineSpacing
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            cellAttrs.append(attr)
            totalHeights[minIndex] = minH + minimumLineSpacing + cellH
        }
        // 4.记录最大值
        maxH = totalHeights.max()!
        // 5.给startIndex重新复制
        startIndex = itemCount
    }
}
// MarK： - 返回准备好的布局
extension NqwlWaterFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
}
// MarK： - 设置contentSize
extension NqwlWaterFlowLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxH + sectionInset.bottom)
    }
}
