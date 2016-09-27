//
//  UIViewControllerExtension.swift
//  Project11_StateLab
//
//  Created by apple on 6/16/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
     在通知中心注册对应状态
     */
    func initAppStateNotificationInViewController() {
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: #selector(self.applicationWillResignActive), name: UIApplicationWillResignActiveNotification, object: nil)
        center.addObserver(self, selector: #selector(self.applicationDidBecomeActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
        center.addObserver(self, selector: #selector(self.applicationDidEnterBackground), name: UIApplicationDidEnterBackgroundNotification, object: nil)
        center.addObserver(self, selector: #selector(self.applicationWillEnterForeground), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    // MARK: - Application State Notifications
    func applicationWillResignActive() {
//        print("VC: \(#function)")
    }
    
    func applicationDidBecomeActive() {
//        print("VC: \(#function)")
    }
    
    func applicationDidEnterBackground() {
//        print("VC: \(#function)")
    }
    
    func applicationWillEnterForeground() {
//        print("VC: \(#function)")
    }
    
}