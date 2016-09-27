//
//  CommUtility.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/11/19.
//  Copyright © 2015年 JasonLu. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony

// MARK: String functions
/** 
 check str is empty
 */
func strIsEmpty(str: String) -> Bool {
    let result = str.compare("")
    
    if result == NSComparisonResult.OrderedSame {
        return true
    }
    
    return false
}



//获取手机语言
//获取国家

// MARK: 常用方法
// -------------------------------常用方法-------------------------------
func checkObjIsNull(object: AnyObject?) -> Bool {
    if object == nil {
        return true
    }
    return false
}

/**
*  保存对应key值
*
*  @param kv      key值
*  @param keyName key的名称
*/
func saveNotificationWithString(key: String , value: String) {
    let defatuls = NSUserDefaults.standardUserDefaults()
    defatuls.setObject(value, forKey: key)
    defatuls.synchronize()
}
/**
 *  读取key对应的值
 *
 *  @param keyName key值
 *
 *  @return key对应的值
 */
func loadNotification(key: String) -> AnyObject? {
    let defaults = NSUserDefaults.standardUserDefaults()
    let value = defaults.objectForKey(key)
    return value
}


func saveNotificationWithBool(key key: String , value: Bool) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setBool(value, forKey: key)
}


func loadBoolNotification(key k:  String) -> Bool {
    let defaults = NSUserDefaults.standardUserDefaults()
    let value = defaults.objectForKey(k)?.boolValue
    return value!
}








