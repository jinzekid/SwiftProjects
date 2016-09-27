//
//  AppDelegate.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/11/16.
//  Copyright © 2015年 JasonLu. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
//    //判断是否更新
//    -(BOOL)isVersionNeedUpdate:(NSString*)newVer currentVersion:(NSString*)currentVer{
//    
//    //[[UIDevice currentDevice].systemVersion floatValue]
//    //该方法不靠谱
//    
//    int compareCN = [currentVer caseInsensitiveCompare:newVer];
//    if (compareCN == 0) {
//    //        NSLog(@"版本一样");
//    return NO;
//    }
//    else if (compareCN < 0) {
//    //        NSLog(@"更新");
//    return YES;
//    }
//    else
//    {
//    //         NSLog(@"不更新");
//    return NO;
//    }
//    }

    
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        UIDevice.currentDevice().systemVersion
//        print("current version \(UIDevice.currentDevice().systemVersion)")
        
        let isGreat = isAppVersionLessEqualThan("1.0.3")
        print("isGreateThanVersion: \(isGreat)")
//        var vehicle = Vehicle()
//        let urlStr = "http://192.168.1.199:8080/api/site/yh/getMySiteList"
//        BasicRequestFactory.shareInstance.requestForPost(urlStr, parameters: nil)
        
//        let url = NSURL(string: "http://192.168.1.199:8080/api/site/sh/getWaitingGrabOrderSiteList")
        
//        let urlStr = "http://192.168.1.199:8080/api/site/sh/getWaitingGrabOrderSiteList"
//        let request = BasicRequestFactory.shareInstance.requestForPost(urlStr, parameters: nil)
//        NetworkManager.shareInstance.sessionReqeust(request!) { (data, response, error) -> Void in
//            if error != nil {
//                print(error?.description)
//            }
//            else {
//                do {
//                    let jsonDic = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
//                    print(jsonDic)
//                } catch let error as NSError {
//                    print("Error: \(error.description)")
//                }
//            }
//        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

