//
//  FileUtility.swift
//  StudyNote
//
//  Created by YangLu on 16/1/3.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import Foundation

func dictionaryFromlocalPlistWithName(plist name: String) -> NSDictionary? {
//    let paths = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true) as NSArray
    if let bundlePath = NSBundle.mainBundle().pathForResource(name, ofType: "plist") {
//        print("bundlePath==\(bundlePath)")
        let resultDic = NSDictionary.init(contentsOfFile: bundlePath)//NSMutableDictionary.init(contentsOfFile: bundlePath)//NSMutableDictionary(contentsOfURL: bundlePath)
        print("resultDic=\(resultDic)")
        return resultDic
    }
    return nil
}

func arrayFromlocalPlistWithName(plist name: String) -> NSArray? {
//    let paths = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true) as NSArray
    if let bundlePath = NSBundle.mainBundle().pathForResource(name, ofType: "plist") {
        //        print("bundlePath==\(bundlePath)")
        let resultArr = NSArray.init(contentsOfFile: bundlePath)// NSDictionary.init(contentsOfFile: bundlePath)//NSMutableDictionary.init(contentsOfFile: bundlePath)//NSMutableDictionary(contentsOfURL: bundlePath)
        print("resultArr=\(resultArr)")
        return resultArr
    }
    return nil
}