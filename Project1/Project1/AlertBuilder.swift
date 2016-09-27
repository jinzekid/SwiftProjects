//
//  AlertBuilder.swift
//  Project1
//
//  Created by apple on 5/30/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import Foundation
import UIKit

struct AlertBuilder {
    /**
     系统创建alert
     - parameters:
        - title: 标题
        - message: 信息
     - returns: 返回提示框对象
     */
    func create(title: String, message: String) -> AnyObject {
        if #available(iOS 9.0, *) {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(okAction)
            return alert
        }
        else {
            let alert = UIAlertView.init(title: title, message:message, delegate: nil, cancelButtonTitle:nil, otherButtonTitles: "OK")
            return alert
        }
    }
}