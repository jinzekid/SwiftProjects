//
//  NetwrokUtility.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/12/17.
//  Copyright © 2015年 JasonLu. All rights reserved.
//
/*
使用方法：
let urlStr = ""
let request = BasicRequestFactory.shareInstance.requestForPost(urlStr, parameters: nil)
NetworkManager.shareInstance.sessionReqeust(request!) { (data, response, error) -> Void in
if error != nil {
print(error?.description)
}
else {
do {
let jsonDic = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
print(jsonDic)
} catch let error as NSError {
print("Error: \(error.description)")
}
}
}
*/

import Foundation

class NetworkManager {
    
    static let shareInstance: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    
    func sessionReqeust(request: NSMutableURLRequest , completionHandler:(NSData? , NSURLResponse , NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data , response , error) -> Void in
            if error != nil {
                completionHandler(nil , response! , error!)
            } else {
                completionHandler(data! , response! , nil)
            }
        }
        task.resume()
    }
    
}
