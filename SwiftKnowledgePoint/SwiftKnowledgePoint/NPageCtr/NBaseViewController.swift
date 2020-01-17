//
//  NBaseViewController.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2019/11/13.
//  Copyright © 2019 Nqwl. All rights reserved.
//

import UIKit

class NBaseViewController: UIViewController {
    lazy var contenTB : UITableView = {
        let tb = UITableView.init(frame: CGRect.zero, style: .plain)
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tb.delegate = self as UITableViewDelegate
        tb.dataSource = self as UITableViewDataSource
        tb.tableFooterView = UIView()
        tb.estimatedRowHeight = 44
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.contenTB.contentInsetAdjustmentBehavior = .never;
        }

        self.contenTB.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavibarH-44)
        self.view.addSubview(contenTB)
    }
    override var shouldAutorotate: Bool {
           return false
    }
    deinit {
    }
}
extension NBaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name.SubScrollNotification, object: nil, userInfo: ["scrollingScrollView":scrollView])
    }
}


extension NBaseViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = "第\(indexPath.row)个"
        return cell
    }

}
