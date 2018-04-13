//
//  PageViewViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/27.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class PageViewViewController: UIViewController {
    fileprivate lazy var dataArray = NSMutableArray()
    @IBOutlet weak var contentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let titles = ["精选","爱看","王牌","斗罗大陆","动漫","电影","综艺","电视剧","小说"]
        var childVCs = [UIViewController]()
        for _ in 0 ..< titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVCs.append(vc)
        }
        //设置样式参数
        let style = NqwlTitleStyle()
        style.titleHeight = 44
        style.isScrollEnable = true
        style.isShowCover = true
        style.isShowBottomLine = true
        style.isNeedScale = true
        style.font = UIFont.systemFont(ofSize: 15.0)
        let layout = NqwlPageCollectionViewLaout()
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 30, 40)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20

        let pageView = NqwlPageView.init(frame: UIScreen.main.bounds, titles: titles, style: style, childVcs: childVCs, parentVc: self)
        view.addSubview(pageView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension PageViewViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
