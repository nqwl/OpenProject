//
//  NContentViewController.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2019/11/13.
//  Copyright © 2019 Nqwl. All rights reserved.
//

import UIKit

class NContentViewController: UIViewController {
    private let headerHeight : CGFloat = 200
    private var childScrollView : UIScrollView = UIScrollView.init()
    lazy var pageView : NqwlPageView = {
        let titles = ["精选","爱看","王牌","斗罗大陆","动漫","电影","综艺","电视剧","小说"]
        var childVCs = [UIViewController]()
        for _ in 0 ..< titles.count {
            let vc = NBaseViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVCs.append(vc)
        }
        //设置样式参数
        let style = NqwlTitleStyle()
        style.titleHeight = 44
        style.isScrollEnable = true
        style.isShowCover = false
        style.isShowBottomLine = true
        style.isNeedScale = false
        let layout = NqwlPageCollectionViewLaout()
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 20, bottom: 30, right: 40)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20
        let view = NqwlPageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavibarH), titles: titles, style: style, childVcs: childVCs, parentVc: self)
        return view
    }()
    lazy var contenTB : NTopTableView = {
        let tb = NTopTableView.init(frame: view.bounds, style: .plain)
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tb.delegate = self as UITableViewDelegate
        tb.dataSource = self as UITableViewDataSource
        
        tb.tableFooterView = UIView()
        let headerV = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: headerHeight))
        headerV.backgroundColor = .randomColor()
        tb.tableHeaderView = headerV
        tb.estimatedRowHeight = 44
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "PageController"
        NotificationCenter.default.addObserver(self, selector: #selector(subScrollNotification(_:)), name: NSNotification.Name.SubScrollNotification, object: nil)
        self.contenTB.frame = CGRect.init(x: 0, y: kNavibarH, width: kScreenW, height: kScreenH-kNavibarH)
        self.view.addSubview(self.contenTB)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    @objc func subScrollNotification(_ notification:NSNotification) {
        let scrollView = notification.object as! UIScrollView;
        self.childScrollView = scrollView
        if self.contenTB.contentOffset.y < self.headerHeight {
            scrollView.contentOffset = CGPoint.zero;
            scrollView.showsVerticalScrollIndicator = false;
        }else {
            scrollView.showsVerticalScrollIndicator = true;
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
extension Notification.Name {
   static let SubScrollNotification = Notification.Name(rawValue:"SubScrollNotification")
}

extension NContentViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        self.pageView.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavibarH)
        cell.contentView .addSubview(self.pageView)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        kScreenH-kNavibarH
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let homeVC = NContentViewController()
            navigationController?.pushViewController(homeVC, animated: true)
        default:
            break
        }
    }
}
extension NContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.contenTB.isEqual(scrollView) {
            if (scrollView.contentOffset.y > self.headerHeight)||(self.pageView.contentView.collectionView.contentOffset.y>0)||(self.childScrollView.contentOffset.y > 0) {
                self.contenTB.contentOffset = CGPoint.init(x: 0, y: self.headerHeight);
            }
            let offSetY = scrollView.contentOffset.y;
            if offSetY <= self.headerHeight {
                NotificationCenter.default.post(name: NSNotification.Name.BottomScrollNotification, object: nil)
            }

        }
    }
}
