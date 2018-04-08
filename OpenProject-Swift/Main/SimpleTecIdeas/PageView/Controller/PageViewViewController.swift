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

        let titles = ["游戏","娱乐娱乐娱乐娱乐娱乐娱乐娱乐","财经","体育","颜值","体娱乐娱乐娱乐娱乐娱乐娱乐育","颜值","体育","颜值"]
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
        let pageView = NqwlPageView.init(frame: UIScreen.main.bounds, titles: titles, childVCs: childVCs, parentVC: self ,style: style)
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
