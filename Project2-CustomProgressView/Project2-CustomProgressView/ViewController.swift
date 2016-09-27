//
//  ViewController.swift
//  Project2-CustomProgressView
//
//  Created by apple on 6/1/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var progressView2: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        progressView1.setParam(style: .Default, trackColor: UIColor.yellowColor(), progressColor: UIColor.blackColor())
        
        progressView2.setParam(style: .Default, trackColor: UIColor.redColor(), progressColor: UIColor.blueColor())
        
        let rectPV2 = progressView2.frame
        let customPV = UIProgressView.init(frame: CGRectMake(progressView2.center.x-150, rectPV2.origin.y + 120, 150, 40), style: .Bar, trackColor: UIColor.redColor(), progressColor: UIColor.purpleColor())
        customPV.setProgress(0.5, animated: false)
        self.view.addSubview(customPV)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

