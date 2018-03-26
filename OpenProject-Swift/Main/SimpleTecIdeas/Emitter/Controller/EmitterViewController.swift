//
//  EmitterViewController.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/26.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit

class EmitterViewController: UIViewController,Emitterable {

    @IBOutlet weak var emitterViewThree: UIView!
    @IBOutlet weak var emitterViewTwo: UIView!
    @IBOutlet weak var emitterViewOne: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startEmittering(imageString: "snow")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
