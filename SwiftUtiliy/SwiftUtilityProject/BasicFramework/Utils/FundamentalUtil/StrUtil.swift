//
//  StrUtil.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 16/9/5.
//  Copyright © 2016年 Fugumobile. All rights reserved.
//

import Foundation
// MARK: -Utility Methods
extension String {
    /**
     保存当前字符串
     
     - parameter key: 对应key值
     
     */
    func saveWithKey(key: String) {
        let defatuls = NSUserDefaults.standardUserDefaults()
        defatuls.setObject(self, forKey: key)
        defatuls.synchronize()
    }
    
    /**
     获取当前对应key的元组(value, key)值
     
     - parameter key: 对应key值
     
     - returns: 返回一个带有value和key的元组(value, key)
     */
    func loadTupleValueKey() -> (value: String, key: String){
        let defaults = NSUserDefaults.standardUserDefaults()
        let value = defaults.objectForKey(self) as! String
        return (value, self)
    }
}