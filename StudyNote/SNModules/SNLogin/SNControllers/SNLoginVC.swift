//
//  SNLoginVC.swift
//  StudyNote
//
//  Created by YangLu on 16/1/3.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import UIKit

class SNLoginVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginDic = dictionaryFromlocalPlistWithName(plist: "Login")
        print("login==\(loginDic)")
        
        let studentsDic = arrayFromlocalPlistWithName(plist: "StudentsList")
        print("Student List:\(studentsDic)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Utility Methods
    @IBAction func loginAction(sender: AnyObject) {
        print("I'm log in...")
        pushToViewController(name: "SNSudentsListVC")
    }
    
}
