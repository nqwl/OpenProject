//
//  MainViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/6.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class Node {
    var  value = 0
    weak var pre : Node?
    weak var nex : Node?
    init(_ value : Int) {
        self.value = value
    }
    deinit {
        print("deinit")
    }
}

class MainViewController: UIViewController {

    @IBOutlet weak var contentTableView: UITableView!
    fileprivate lazy var dataArray : [String] = ["简单的瀑布流","雪花粒子动画效果","仿腾讯视频选项卡效果","微信表情键盘效果(优化版)","Gif播放","音频采集","GPUImage使用"]


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        print("\(UIScreen.main.bounds)+\(self.view.bounds)")
        let a = Node.init(1)
        let b = Node.init(2)
        a.pre = b
        b.nex = a

        var array = [1,2,3,4]
        swapNum(&array, 1, 2)

        let addTwo = add(num: 2)
        let result = addTwo(2)
        print(result)
    }
    func add(num:Int) -> (Int) -> Int {
        return { value in
            return value + num
        };
    }
    func swapNum<T>(_ arr:inout [T],_ a:Int,_ b:Int)  {
        if a < 0 || a > arr.count - 1 || b < 0 || b > arr.count - 1 || a == b {
            return
        }
        (arr[a],arr[b]) = (arr[b],arr[a])
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
        case 2:
            let pageViewVC = PageViewViewController()
            navigationController?.pushViewController(pageViewVC, animated: true)
            break
        case 3:
            let emojiViewVC = EmojiViewController()
            navigationController?.pushViewController(emojiViewVC, animated: true)
            break
        case 4:
            let gifVC = GifViewController()
            navigationController?.pushViewController(gifVC, animated: true)
            break
        case 5:
            let capVC = CaptrueViewController()
            navigationController?.pushViewController(capVC, animated: true)
            break
        case 6:
            let gpuVC = GPUImageViewController()
            navigationController?.pushViewController(gpuVC, animated: true)
            break
        default:
            break
        }
    }
}
