//
//  AppDelegate.swift
//  Project6_ReadLocalFile
//
//  Created by apple on 6/15/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // save data to Local
        saveDataToLocal()

        // read data from app sandbox
        let path = localFilePath("contacts.plist")
        let arr = NSArray(contentsOfFile: path)
        print("local arr==\(arr)")
        
        // read data from project
        let dicPath = NSBundle.mainBundle().pathForResource("names", ofType: "plist", inDirectory: nil, forLocalization: nil)
        let dic = NSArray(contentsOfFile: dicPath!)
        print("dic==\(dic)")
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

    func saveDataToLocal() {
        let fileManager: NSFileManager = NSFileManager.defaultManager()
        let plistPath = localFilePath("contacts.plist")
        
        if fileManager.fileExistsAtPath(plistPath) == false {
            let contacts: NSMutableArray = NSMutableArray()
            contacts.addObject("Elana")
            contacts.addObject("Sonam")
            contacts.addObject("Jane")
            contacts.addObject("Paul")
            contacts.addObject("Abhishek")
            contacts.addObject("Nick")
            contacts.addObject("Steve")
            
            contacts.writeToFile(plistPath, atomically: true)
        }
    }
    
    func localFilePath(fileName: String!) -> String! {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let path = paths.stringByAppendingString("/" + fileName)
        return path
    }
}

