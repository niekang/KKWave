//
//  ViewController.swift
//  KKWave
//
//  Created by 聂康  on 2017/5/27.
//  Copyright © 2017年 聂康. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var wave:KKWave?

    override func viewDidLoad() {
        super.viewDidLoad()
        wave =  KKWave(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 140))
        wave?.image = #imageLiteral(resourceName: "wave")
        view.addSubview(wave!)
        wave?.startWave()
    }


}

