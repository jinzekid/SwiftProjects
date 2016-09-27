//
//  ViewController.swift
//  UniversalTest
//
//  Created by apple on 6/15/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        @IBOutlet weak var kk: UILabel!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var ageLabel: UILabel!
        @IBOutlet weak var nameLabel: UILabel!
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(_:)))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleBackgroundTap(sender: UITapGestureRecognizer) {
        self.userTextField.resignFirstResponder()
        self.pwdTextField.resignFirstResponder()
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        userTextField.resignFirstResponder()
        pwdTextField.resignFirstResponder()
        
        let userName: String = userTextField.text!
        let length: Int = userName.characters.count
        
        if length == 0 {
            return
        }
        
        let alert = UIAlertController(title: "", message: "Login successful", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            print("ok ....");
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

