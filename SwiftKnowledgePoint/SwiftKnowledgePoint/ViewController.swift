//
//  ViewController.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2019/11/12.
//  Copyright © 2019 Nqwl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var contenTB : UITableView = {
        let tb = UITableView.init(frame: view.bounds, style: .plain)
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tb.delegate = self as UITableViewDelegate
        tb.dataSource = self as UITableViewDataSource
        tb.tableFooterView = UIView()
        tb.estimatedRowHeight = 44
        return tb
    }()
    lazy var dataArray : Array<String> = {
        ["PageController","Swift基础知识点"]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift"
        self.view.addSubview(contenTB)
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = self.dataArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let homeVC = NContentViewController()
            navigationController?.pushViewController(homeVC, animated: true)
        case 1:
            let pointVC = PointViewController()
            navigationController?.pushViewController(pointVC, animated: true)
        default:
            break
        }
    }
}
