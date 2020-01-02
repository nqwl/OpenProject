//
//  NSearchViewController.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2019/11/29.
//  Copyright © 2019 Nqwl. All rights reserved.
//

import UIKit

class NSearchViewController: UIViewController {
    var alpha : CGFloat = 0
    let headerHeight : CGFloat = 44
    private lazy var childScrollView : UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.isScrollEnabled = false
        scrollView.delegate = self
        return scrollView
    }()

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
        self.childScrollView.frame = self.view.bounds
        view.addSubview(self.childScrollView)
        self.headerView.frame  = CGRect.init(x: 0, y: -kNavibarH, width: kScreenW, height: headerHeight+kNavibarH)
        self.searchBtn.frame  = CGRect.init(x: 10, y: kNavibarH + 5, width: kScreenW-20, height: 34)
        self.headerView.addSubview(self.searchBtn)
        self.childScrollView.addSubview(self.headerView)
        contentTB.frame = CGRect.init(x: 0, y: headerHeight, width: kScreenW, height: kScreenH-headerHeight-kNavibarH)
        self.childScrollView.addSubview(contentTB)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
}

extension NSearchViewController: UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY <= headerHeight {
            self.childScrollView.contentOffset = scrollView.contentOffset
            self.contentTB.contentOffset  = CGPoint.zero
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}
