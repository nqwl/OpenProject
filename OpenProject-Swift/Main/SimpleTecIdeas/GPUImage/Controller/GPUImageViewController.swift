//
//  GPUImageViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/4/13.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit
import GPUImage

class GPUImageViewController: UIViewController {
    @IBOutlet weak var contentTableView: UITableView!
    fileprivate lazy var dataArray = NSMutableArray.init(array: ["毛玻璃效果"])
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTableView.tableFooterView = UIView()
        self.contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "kGPUCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension GPUImageViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kGPUCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = self.dataArray[indexPath.row] as? String
        cell.textLabel?.font = kAdaptedFontSize(x: 14)
        cell.textLabel?.textColor = UIColor.init(r: 33, g: 33, b: 33)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
}
