//
//  EmojiViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/4/8.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class EmojiViewController: UIViewController {

    fileprivate var titles = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let pageFrame = CGRect(x: 0, y: kScreenH - 260, width: kScreenW, height: 200)

        titles = ["QQ", "小浪花"]
        let style = NqwlTitleStyle()
        style.isShowBottomLine = true
        style.isShowCover = true
        style.coverH = 40
        style.coverRadius = 0
        style.coverMargin = 0
        style.coverBgColor = UIColor.groupTableViewBackground
        let layout = NqwlPageCollectionViewLaout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.cols = 7
        layout.rows = 3

        let pageCollectionView = NqwlPageCollectionView(frame: pageFrame, titles: titles, style: style, isTitleInTop: false, layout: layout)

        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        pageCollectionView.register(nib: UINib.init(nibName: "EmojiCell", bundle: nil), identifier: "EmojiCell")

        view.addSubview(pageCollectionView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension EmojiViewController :NqwlPageCollectionViewDelegate {
    func pageCollectionView(_ collectionView: NqwlPageCollectionView, didSelectedItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
extension EmojiViewController : NqwlPageCollectionViewDataSource {
    func numberOfSections(in pageCollectionView: NqwlPageCollectionView) -> Int {
        return EmotionViewModel.shareInstance.packages.count
    }

    func pageCollectionView(_ collectionView: NqwlPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmotionViewModel.shareInstance.packages[section].count
    }

    func pageCollectionView(_ pageCollectionView: NqwlPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
        if indexPath.section == 0 {
            let emojiModel = EmotionViewModel.shareInstance.packages[indexPath.section][indexPath.row] as! QQEmotionModel
            cell.configCellWithQQ(model: emojiModel)
        }else if indexPath.section == 1 {
            let emojiModel = EmotionViewModel.shareInstance.packages[indexPath.section][indexPath.row] as! LXHEmotionModel
            cell.configCellWithLXH(model: emojiModel)
        }
        return cell
    }
}
