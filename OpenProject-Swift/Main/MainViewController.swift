//
//  MainViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/6.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit
//美女 性感
//http://image.baidu.com/wisebrowse/data?tag1=%E7%BE%8E%E5%A5%B3&tag2=%E6%80%A7%E6%84%9F&pn=0&rn=60
class MainViewController: UIViewController {

    @IBOutlet weak var contentTableView: UITableView!
    fileprivate lazy var dataArray : NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MainViewController {
    fileprivate func setupUI() {
        self.contentTableView.register(UINib.init(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        self.contentTableView.tableFooterView = UIView()
        self.contentTableView.backgroundColor = .groupTableViewBackground
    }
    fileprivate func getData() {

    }

}
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainCell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
