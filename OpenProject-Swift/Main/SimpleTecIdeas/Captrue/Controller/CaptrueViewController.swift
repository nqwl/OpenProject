//
//  CaptrueViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/4/13.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class CaptrueViewController: UIViewController {
    fileprivate lazy var manager : AVCaptrueManager = AVCaptrueManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.setupVideoInputOutput()
        manager.setupAudioInputOutput()
    }

    @IBAction func romateCaptruingBtnClick(_ sender: Any) {
        self.manager.rotateCamera()
    }
    @IBAction func stopCaptruingBtnClick(_ sender: Any) {
        self.manager.stopCapturing()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func startCaptruingBtnClick(_ sender: Any) {
        self.manager.startCapturing(preview: self.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
