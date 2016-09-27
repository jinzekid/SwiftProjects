//
//  FileUtility.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/12/4.
//  Copyright © 2015年 JasonLu. All rights reserved.
//

import Foundation

// MARK: - Utility Methods
/*!
 返回缓存文件路径
 
 - parameter name: 文件名
 
 - returns: 文件路径
 */
func fileCahesPath(name: String) -> String {
    let paths: Array = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
    let documentsDirectory = paths[0]
    return "\(documentsDirectory)/\(name)"
}

/*!
 指定文件是否存在
 
 - parameter fileName: 文件名
 
 - returns: 是否存在
 */
func isExistFile(fileName: String) -> Bool {
    let fileManager = NSFileManager.defaultManager()
    let filePath = fileCahesPath(fileName)
    
    return fileManager.fileExistsAtPath(filePath)
}

/*!
 删除指定文件
 
 - parameter fileName: 文件名
 
 - returns: 删除是否成功
 */

func removeFile(fileName: String) -> Bool {
    
    let fileManager = NSFileManager.defaultManager()
    do {
        try fileManager.removeItemAtPath(fileCahesPath(fileName))
        return true
    }catch let error as NSError{
        print("Error: \(error.domain)")
    }
    
    return false
}

/*!
 移动文件
 
 - parameter srcFileName: 源文件目录
 - parameter desFileName: 目标文件目录
 
 - returns: 是否移动成功
 */
func moveFileToDestination(srcFileName: String , desFileName: String) -> Bool {
    
    let fileManager = NSFileManager.defaultManager()
    
    do {
        try fileManager.moveItemAtPath(srcFileName, toPath: desFileName)
    }catch let error as NSError {
        print("Error: \(error.domain)")
    }
    
    return false
}

/**
 读取本地plist文件
 
 - parameter name: 文件名字
 
 - returns: 返回本地plist文件内容
 */
func localPlistWithName(plist name: String) -> NSDictionary? {
    
    //    let paths = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true) as NSArray
    //    let documentDirectory = paths[0] as! String
    //    let filePath = documentDirectory.stringByAppendingString(name)
    //    let fileManager = NSFileManager.defaultManager()
    
    if let bundlePath = NSBundle.mainBundle().pathForResource(name, ofType: "plist") {
        let resultDic = NSDictionary.init(contentsOfFile: bundlePath)
        return resultDic
    }
    return nil
}


//+ (BOOL)removeFilePath:(NSString*)fileName
//{
//    NSFileManager *defaultManager;
//    defaultManager = [NSFileManager defaultManager];
//    NSError* error;
//    BOOL isSuccess = [defaultManager removeItemAtPath:[LocalFileSaveController getFileCahesPath:fileName] error:&error];
//    return isSuccess;
//}