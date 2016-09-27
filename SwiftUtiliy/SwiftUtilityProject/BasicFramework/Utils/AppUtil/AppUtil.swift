//
//  AppUtil.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 16/9/5.
//  Copyright © 2016年 TDENERGYs. All rights reserved.
//

import Foundation

// MARK: -Utility Methods
/**
 检查App当前版本是否小于需要比较的版本号
 
 - parameter ver: 需要比较的版本号
 
 - returns: 是否比当前版本小于或者等于
 */
func isAppVersionLessEqualThan(ver : String) -> Bool {
    
    let mainBundle = NSBundle.mainBundle()
    
    let appVer:AnyObject? = mainBundle.objectForInfoDictionaryKey("CFBundleShortVersionString")
    print("curren ver: \(appVer)")
    
    let result = appVer?.caseInsensitiveCompare(ver)
    if result == NSComparisonResult.OrderedAscending {
        return true
    }
    return false
}

/**
 获取App的名字
 
 - returns: App的名字
 */
func appName() -> String {
    let mainBundle = NSBundle.mainBundle()
    
    let str:AnyObject? = mainBundle.objectForInfoDictionaryKey("CFBundleDisplayName")
    
    return (str) as! String
}

/**
 获取APP应用版本

 - returns: APP应用版本
 */
func appVersion() -> String {
    let mainBundle = NSBundle.mainBundle()
    
    let str:AnyObject? = mainBundle.objectForInfoDictionaryKey("CFBundleShortVersionString")
    
    return (str) as! String
}

/**
 获取APP应用build版本
 
 - returns: APP应用build版本
 */
func appBuildVersion() -> String {
    let mainBundle = NSBundle.mainBundle()
    
    let str:AnyObject? = mainBundle.objectForInfoDictionaryKey("CFBundleVersion")
    
    return (str) as! String
}