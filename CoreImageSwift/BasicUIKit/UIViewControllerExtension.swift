//
//  UIViewControllerExtension.swift
//  CoreImageSwift
//
//  Created by apple on 6/22/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    #if swift(>=2.3)
    func hiddenNavigationBar(_ isHidden: Bool) {
        self.navigationController?.setNavigationBarHidden(isHidden, animated: false)
    }
    #else
    func hiddenNavigationBar(isHidden: Bool) {
        self.navigationController?.setNavigationBarHidden(isHidden, animated: false)
    }
    #endif
}
