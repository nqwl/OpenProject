//
//  MainViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/6.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var contentTableView: UITableView!
    fileprivate lazy var dataArray : [String] = ["简单的瀑布流","雪花粒子动画效果"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        print("\(UIScreen.main.bounds)+\(self.view.bounds)")
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
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainCell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.textLabel?.font = kAdaptedFontSize(x: 14)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let waterflowVC = WaterFlowViewController()
            self.navigationController?.pushViewController(waterflowVC, animated: true)
            break
        case 1:
            let emitterVC = EmitterViewController()
            self.navigationController?.pushViewController(emitterVC, animated: true)
            break
        default:
            break
        }

    }
}
