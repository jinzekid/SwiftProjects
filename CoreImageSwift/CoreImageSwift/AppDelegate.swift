//
//  AppDelegate.swift
//  CoreImageSwift
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootNavigationController: UINavigationController?

//    func systemSupprotFont () {
//        for name in UIFont.familyNames() {
//            print(name)
//            if let nameString: String? = name {
//                print("Support Font:\(UIFont.fontNames(forFamilyName: nameString!))")
//            }
//        }
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        systemSupprotFont()
        
        initAppNavigationController()
        pushVCByXibWithName(name: "CIMainViewController")
        
        let filterList = buildInFilterList()
//        for (index, filterName) in filterList.enumerated() {
//            let filter = buildInFilter(at: index)//buildInFilterAtIndex(index)
//            print("-----------------------\n")
//            print("filterName:\(filterName)")
//            print("attributes:\(filter.attributes)")
//            print("inputKeys:\(filter.inputKeys)")
//            print("---------------------\n")
//        }
        
//        let categoryArr = [kCICategoryColorEffect,kCICategoryColorAdjustment]
//        let categoryList = CIFilter.filterNames(inCategories: [kCICategoryColorAdjustment])
//        print("categoryList==\(categoryList)")
//        for filterName in categoryList {
//            let filter = CIFilter(name: filterName)
//            print("FilterName:\(filterName)")
//            print("FilterInputKeys:\(filter?.inputKeys)")
//            print("------------------------------")
//        }
        
//        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
//        let anyObjectType: AnyObject.Type = NSClassFromString(ns+"."+vcName)!
//        
//        if anyObjectType is UIViewController.Type {
//            let newVC = (anyObjectType as! UIViewController.Type).init(nibName: vcName, bundle: nil)
//            currentNavigationController().pushViewController(newVC, animated: true)
//        }
        
        
//        let mainVC = UIViewController.init(nibName: "CIMainViewController", bundle: nil)
//        window?.rootViewController = mainVC
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Utility Methods
    func initAppNavigationController() {
        let stroyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        rootNavigationController = stroyBoard.instantiateViewController(withIdentifier: "RootNavigationController") as? UINavigationController
        self.window?.rootViewController = rootNavigationController
    }
}

