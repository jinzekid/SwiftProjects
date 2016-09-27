//
//  AppUtility.swift
//  StudyNote
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import Foundation
import UIKit

func currentAppDelegate() -> AppDelegate {
    return UIApplication.sharedApplication().delegate as! AppDelegate
}

func currentNavigationController() -> UINavigationController {
    return currentAppDelegate().rootNavigationController!
}

func currentStoryboard() -> UIStoryboard {
    return UIStoryboard.init(name: "Main", bundle: nil)
}

func pushToViewController(name vcName: String) {
    let storybaord = currentStoryboard()
    let vc = storybaord.instantiateViewControllerWithIdentifier(vcName)
    currentNavigationController().pushViewController(vc, animated: true)
}
