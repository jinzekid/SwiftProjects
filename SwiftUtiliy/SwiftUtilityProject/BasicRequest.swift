//
//  BasicRequest.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/12/17.
//  Copyright © 2015年 JasonLu. All rights reserved.
//

import Foundation

class BasicRequestFactory {
    
    static let shareInstance: BasicRequestFactory = {
        let instance = BasicRequestFactory()
        return instance
    }()
    
    // MARK: - Utility Methods
    func requestForPost(basicUrl: String , parameters: Dictionary<String, AnyObject>?) -> NSMutableURLRequest? {
        
        if parameters == nil {
            let request = newRequest(basicUrl)
            return request
        }
        else {
            do {
                let jsonData = try NSJSONSerialization.dataWithJSONObject(parameters!, options: NSJSONWritingOptions.PrettyPrinted)
                
                let request = newRequest(basicUrl)
                request.setValue(String(format: "％lu", jsonData.length) , forHTTPHeaderField: "Content-length")
                request.HTTPBody = jsonData
                
                return request
            } catch let error as NSError {
                print("Error: \(error.description)")
            }
            return nil
        }
    }
    
    // MARK: - Private Methods
    private func newRequest(basicUrl: String) -> NSMutableURLRequest {
        let url = NSURL.init(string: basicUrl)
        let request = NSMutableURLRequest.init(URL: url!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 30.0)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request;
    }
}