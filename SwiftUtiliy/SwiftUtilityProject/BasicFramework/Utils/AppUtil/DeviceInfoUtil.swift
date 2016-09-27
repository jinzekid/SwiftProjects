//
//  DeviceInfo.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 16/9/5.
//  Copyright © 2016年 TDENERGYs. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony

// MARK: -Utility Methods
func currentDevice() -> UIDevice {
    return UIDevice.currentDevice()
}

//获取设备所有者的名称
func deviceName() -> String {
    return currentDevice().name
}

//获取设备的类别
func deviceModel() -> String {
    return currentDevice().model
}

//获取本地化版本
func deviceLocalizeModel() -> String {
    return currentDevice().localizedModel
}

//获取当前运行的系统
func deviceSytemName() -> String {
    return currentDevice().systemName
}

//获取当前系统的版本
func deviceSystemVersion() -> String {
    return currentDevice().systemVersion
}

//获取当前屏幕分辨率的信息
func deviceResulotionInfo() -> CGSize {
    
    let rect = UIScreen.mainScreen().bounds
    let scale = UIScreen.mainScreen().scale
    
    return CGSizeMake(rect.width * scale, rect.height * scale)
}

//获取屏幕大小
func deviceScreenBounds() -> CGRect {
    return UIScreen.mainScreen().bounds
}
//获取运行商的名称
//需要导入头文件
/*
 #import <CoreTelephony/CTCarrier.h>
 #import <CoreTelephony/CTTelephonyNetworkInfo.h>
 */
func deviceCarrierName() -> String {
    let info    = CTTelephonyNetworkInfo.init()
    let carrier = info.subscriberCellularProvider
    
    //    let mCarrier = carrier.ob
    return (carrier?.carrierName)!
    //    return mCarrier!
}