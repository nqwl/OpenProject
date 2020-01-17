//
//  NSearchViewController.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2019/11/29.
//  Copyright © 2019 Nqwl. All rights reserved.
//

import UIKit

class NGifListViewController: UIViewController {

    private lazy var contentTB : UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.register(NGifCell.self, forCellReuseIdentifier: "NGifCell")
        tableView.tableFooterView = UIView()
        return tableView
    }();

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

extension NGifListViewController: UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NGifCell = tableView.dequeueReusableCell(withIdentifier: "NGifCell", for: indexPath) as! NGifCell

        let path = Bundle.main.path(forResource: "\(indexPath.row)", ofType: "gif")
        let data = NSData(contentsOfFile: path!)!
//        let options: NSDictionary = [kCGImageSourceShouldCache as String: NSNumber.init(booleanLiteral: true), kCGImageSourceTypeIdentifierHint as String: "kUTTypeGIF"]
//        CGImageSourceCreateWithData(data, options)
        cell.gifImageView.image = UIImage.init(data: data as Data)
        return cell
    }
}
