//
//  EmojiViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/4/8.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class EmojiViewController: UIViewController {

    fileprivate lazy var dataArray = [NSArray]()
    fileprivate var titles = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()

        let pageFrame = CGRect(x: 0, y: 100, width: kScreenW, height: 200)

        titles = ["QQ", "小浪花"]
        let style = NqwlTitleStyle()
        style.isShowBottomLine = true
        
        let layout = NqwlPageCollectionViewLaout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.cols = 7
        layout.rows = 3

        let pageCollectionView = NqwlPageCollectionView(frame: pageFrame, titles: titles, style: style, isTitleInTop: true, layout: layout)

        pageCollectionView.dataSource = self
        pageCollectionView.register(nib: UINib.init(nibName: "EmojiCell", bundle: nil), identifier: "EmojiCell")

        view.addSubview(pageCollectionView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension EmojiViewController {
    fileprivate func requestData() {
        let emotionBundle = kFindeNSBunld(bundleName: "XEmotionIcons")

        let qqPath = "\(emotionBundle)/QQEmotion/QQEmtion.plist"
        let qqEmtionArr = NSArray.init(contentsOfFile: qqPath)


        let lxhPath = "\(emotionBundle)/lxh/info.plist"
        let lxhEmtionArr = NSArray.init(contentsOfFile: lxhPath)
        
        self.dataArray.append(qqEmtionArr!)
        self.dataArray.append(lxhEmtionArr!)
    }
}
extension EmojiViewController : NqwlPageCollectionViewDataSource {
    func numberOfSections(in pageCollectionView: NqwlPageCollectionView) -> Int {
        return titles.count
    }

    func pageCollectionView(_ collectionView: NqwlPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray[section].count
    }

    func pageCollectionView(_ pageCollectionView: NqwlPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
//        print(cell.description)
//        cell.backgroundColor = UIColor.randomColor()
        let emojiDic = self.dataArray[indexPath.section][indexPath.row] as! NSDictionary
        if indexPath.section == 0 {
            cell.iconImageView.image = kGETNSbunldINImage(bundleName: "XEmotionIcons", subPath: "/QQEmotion/", imageName: emojiDic["png"] as! String)
        }else if indexPath.section == 1 {
            cell.iconImageView.image = kGETNSbunldINImage(bundleName: "XEmotionIcons", subPath: "/lxh/", imageName: emojiDic["png"] as! String)
        }
        return cell
    }
}
