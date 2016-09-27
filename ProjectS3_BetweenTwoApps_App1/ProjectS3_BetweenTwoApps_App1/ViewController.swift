//
//  ViewController.swift
//  ProjectS3_BetweenTwoApps_App1
//
//  Created by apple on 6/27/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchAppAction(_ sender: AnyObject) {
        let urlString = "App2://GarveyCalvin"
        
        if #available(iOS 10.0, *) {
            if let url = URL(string: urlString) {
                let application = UIApplication.shared()
                if application.canOpenURL(url) {
                    application.open(url, options: ["option1":"value1","option2":"value2"], completionHandler: nil)
                }
            }
        } else {
            // Fallback on earlier versions
            if let url = NSURL(string: urlString) {
                let application = UIApplication.shared()
                if application.canOpenURL(url as URL) {
                    if #available(iOS 10.0, *) {
                        application.open(url as URL, options: ["option1":"value1","option2":"value2"], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
    }

    @IBAction func jumpToweChat(_ sender: AnyObject) {
        let urlString = "weixin://"
        
        if let url = URL(string: urlString) {
            let application = UIApplication.shared()
            if application.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    application.open(url, options: ["option1":"value1","option2":"value2"], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
    }
}

