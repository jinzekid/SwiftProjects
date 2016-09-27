//
//  ViewController.swift
//  Project1
//
//  Created by apple on 5/30/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func createAlertAction(sender: AnyObject) {
        let alert = AlertBuilder().create("Alert", message: "I'm a Alert!")
        if #available(iOS 9.0, *) {
            self.presentViewController(alert as! UIViewController, animated: true, completion: nil)
        } else {
            alert.show()
        }
//
//        alert.show()
        
//        if #available(iOS 8.0, *) {
//            
//            // prevent show too many times
//            guard let _ = sg_hyb_alert_actionsheet_controller else {
//                return
//            }
//            
//            let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
//            
//            if let actions = alertActions {
//                for alertAction in actions {
//                    alertController.addAction(alertAction)
//                }
//            }
//            
//            sg_hyb_alert_actionsheet_controller = alertController
//            self.presentViewController(alertController, animated: true, completion: nil)
//        } else {
//            UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: ok).show() }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        print("buttonIndex=\(buttonIndex)")
    }

}

