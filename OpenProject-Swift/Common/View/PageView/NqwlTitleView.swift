//
//  NqwlTitleView.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/27.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

protocol NqwlTitleViewDelegate : class {
    func titleView(_ titleView : NqwlTitleView,tagetIndex:Int)
}
private let kTitleViewCellID = "NqwlTitleCell"
class NqwlTitleView: UIView {

    weak var delegate : NqwlTitleViewDelegate?

    fileprivate var titles : [String]
    fileprivate var style : NqwlTitleStyle
    fileprivate var titleW : [CGFloat]
    fileprivate var selectedIndex : IndexPath

    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource  = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "\(NqwlTitleCell.self)", bundle: nil), forCellWithReuseIdentifier: kTitleViewCellID)

        return collectionView
    }()
    init(frame: CGRect ,titles: [String] ,style : NqwlTitleStyle) {
        self.titles = titles
        self.style = style
        var w : CGFloat = 0
        var titlesW = [CGFloat]()

        for (_, title) in titles.enumerated() {
            w = (title as NSString).boundingRect(with: CGSize(width:CGFloat(MAXFLOAT),height:0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : kAdaptedFontSize(x: style.fontSize)], context: nil).width
            titlesW.append(w)
        }
        self.selectedIndex = NSIndexPath.init(row: 0, section: 0) as IndexPath
        self.titleW = titlesW
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension NqwlTitleView {
    fileprivate func setupUI() {
        addSubview(collectionView)
    }
}
extension NqwlTitleView : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTitleViewCellID, for: indexPath) as! NqwlTitleCell
        cell.bottomView.isHidden = self.selectedIndex.row == indexPath.row ? false : true
        cell.titleContentLabel.font = self.selectedIndex.row == indexPath.row ? kAdaptedFontSize(x: style.sourceonFontSize) : kAdaptedFontSize(x: style.fontSize)
        cell.titleContentLabel.textColor = self.selectedIndex.row == indexPath.row ? style.selectedColor : style.normalColor
        cell.bottomView.backgroundColor = style.bottomViewColor
        cell.titleTop.constant = style.titleTop
        cell.bottomViewTop.constant = style.bottomTop
        cell.titleContentLabel.text = titles[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
        selectedIndex = indexPath
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTitleViewCellID, for: indexPath) as! NqwlTitleCell
        delegate?.titleView(self, tagetIndex: indexPath.row)
        if style.isScrollEnable {
            var offsetX = (cell.center.x - collectionView.bounds.width * 0.5)
            if offsetX < 0 {
                offsetX = CGFloat.init(0)
            }
            if offsetX > (collectionView.contentSize.width - collectionView.bounds.width) {
                offsetX = collectionView.contentSize.width - collectionView.bounds.width
            }
            collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.titleW[indexPath.row] + 40, height: style.titleHeight)
    }
}
// MARK:- 准守NqwlContentViewDelegate
extension NqwlTitleView : NqwlContentViewDelegate {
    func contentView(_ contentView: NqwlContentView, targetIndex: Int) {
        adjustTitleLable(targetIndex: targetIndex)
    }

    func contentView(_ contentView: NqwlContentView, targetIndex: Int, progress:CGFloat) {

    }
    fileprivate func adjustTitleLable(targetIndex:Int) {
        self.selectedIndex = IndexPath(row: targetIndex, section: 0)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTitleViewCellID, for: self.selectedIndex) as! NqwlTitleCell
        //居中效果
        if style.isScrollEnable {
            var offsetX = (cell.center.x - collectionView.bounds.width * 0.5)
            if offsetX < 0 {
                offsetX = CGFloat.init(0)
            }
            if offsetX > (collectionView.contentSize.width - collectionView.bounds.width) {
                offsetX = collectionView.contentSize.width - collectionView.bounds.width
            }
            collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        }
        self.collectionView.reloadData()
    }
}
