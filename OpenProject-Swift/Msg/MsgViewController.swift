//
//  MsgViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/6.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class MsgViewController: UIViewController {

    fileprivate lazy var contentCollectionView : UICollectionView =  {
        let  layout = NqwlWaterFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.dataSource = self
        
        let collectionView = UICollectionView.init(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self

        print("\(UIScreen.main.bounds)+\(self.view.bounds)")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MsgViewController : NqwlWaterFlowLayoutDataSource {
    func numberOfCols(_ waterfallLaout: NqwlWaterFlowLayout) -> Int {
         return 4
    }
    func waterfall(_ waterfallLaout: NqwlWaterFlowLayout, item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(150)+100)
    }
}

extension MsgViewController {
    fileprivate func setupUI() {
        self.view.addSubview(contentCollectionView)
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        contentCollectionView.backgroundColor = .white
    }
}

extension MsgViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
    }
}

