//
//  NSearchViewController.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2019/11/29.
//  Copyright © 2019 Nqwl. All rights reserved.
//

import UIKit

class NSearchViewController: UIViewController {

    private lazy var contentTB : NTopTableView = {
        let tableView = NTopTableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }();
    private lazy var headerView: UIView = {
        let view = UIView.init(frame: CGRect.zero)
        return view
    }();
    private lazy var searchBtn: UIButton = {
        let searchBtn = UIButton.init(type: UIButton.ButtonType.custom)
        searchBtn.backgroundColor = kThemeGainsboroColor
        searchBtn.layer.cornerRadius  = 17
        searchBtn.layer.masksToBounds = true
        searchBtn.setImage(UIImage.init(named: "icon_search"), for: UIControl.State.normal)
        searchBtn.setTitle("搜索", for: UIControl.State.normal)
        searchBtn.setTitleColor(kThemeGainsboroColor, for: UIControl.State.normal)
        return searchBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kThemeWhiteColor
        createUI()
        // Do any additional setup after loading the view.
    }
    func createUI() {
        self.view.addSubview(contentTB)
        contentTB.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension NSearchViewController: UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
