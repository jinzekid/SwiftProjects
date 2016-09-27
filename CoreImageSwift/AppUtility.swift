//
//  AppUtility.swift
//  StudyNote
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import Foundation
import UIKit

func currentNavigationController() -> UINavigationController {
    // FIXME: - 需要自定义navigationController
    //    return UINavigationController.init()
    return currentAppDelegate().rootNavigationController!
}

func currentStoryboard() -> UIStoryboard {
    return UIStoryboard.init(name: "Main", bundle: nil)
}

func pushVCByXibWithNewVC(vc vcontroller: UIViewController) {
    currentNavigationController().pushViewController(vcontroller, animated: true)
}

#if swift(>=2.3)
func currentAppDelegate() -> AppDelegate {
    return UIApplication.shared().delegate as! AppDelegate
}

func pushVCByStoryboardWithName(name vcName: String) {
    let storybaord = currentStoryboard()
    let vc = storybaord.instantiateViewController(withIdentifier: vcName)
    currentNavigationController().pushViewController(vc, animated: true)
}

func pushVCByXibWithName(name vcName: String) {
    let ns = Bundle.main().infoDictionary!["CFBundleExecutable"] as! String
    let anyObjectType: AnyObject.Type = NSClassFromString(ns+"."+vcName)!
    
    if anyObjectType is UIViewController.Type {
        let newVC = (anyObjectType as! UIViewController.Type).init(nibName: vcName, bundle: nil)
        currentNavigationController().pushViewController(newVC, animated: true)
    }
}

func presentVCByXibWithName(_ vcName: String) {
    let ns = Bundle.main().infoDictionary!["CFBundleExecutable"] as! String
    let anyObjectType: AnyObject.Type = NSClassFromString(ns+"."+vcName)!
    
    if anyObjectType is UIViewController.Type {
        let newVC = (anyObjectType as! UIViewController.Type).init(nibName: vcName, bundle: nil)
        currentNavigationController().present(newVC, animated: true, completion: nil)
    }
}
#else
    func currentAppDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    func pushVCByStoryboardWithName(name vcName: String) {
        let storybaord = currentStoryboard()
        let vc = storybaord.instantiateViewControllerWithIdentifier(vcName)
        currentNavigationController().pushViewController(vc, animated: true)
    }
    
    func pushVCByXibWithName(name vcName: String) {
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let anyObjectType: AnyObject.Type = NSClassFromString(ns+"."+vcName)!
        
        if anyObjectType is UIViewController.Type {
            let newVC = (anyObjectType as! UIViewController.Type).init(nibName: vcName, bundle: nil)
            currentNavigationController().pushViewController(newVC, animated: true)
        }
    }
    
    func presentVCByXibWithName(vcName: String) {
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let anyObjectType: AnyObject.Type = NSClassFromString(ns+"."+vcName)!
        
        if anyObjectType is UIViewController.Type {
            let newVC = (anyObjectType as! UIViewController.Type).init(nibName: vcName, bundle: nil)
            currentNavigationController().presentViewController(newVC, animated: true, completion: nil)
        }
    }
#endif

/**
 泛型数组查找对应index
 
 - parameter array:       数组对象
 - parameter valueToFind: 被查找值
 
 - returns: 返回index，可能为空
 */
//func findArrayIndex<T: Equatable> (_ array: [T] , _ valueToFind: T) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}

/*!
判断当前版本是否需要升级

- parameter newVersion: 新版本

- returns: 是否需要升级,如果当前版本是1.0，新版本是1.0.0，也是返回true
*/
//func isAppVersionNeedUpdate(_ newVersion: String) -> Bool {
//    let currentVersion = Bundle.main().infoDictionary!["CFBundleShortVersionString"] as! String;
//    let result = currentVersion.caseInsensitiveCompare(newVersion);
//    if result == .orderedAscending{
//        return true
//    }
//    return false
//}

