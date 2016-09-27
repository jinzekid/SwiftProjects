//: Playground - noun: a place where people can play

import UIKit
//import CoreTelephony/CTCarrier
//import CoreTelephony/CTTelephonyNetworkInfo
//import  CoreTelephony/CTCarrier
import   CoreTelephony

func strIsEmpty(str: String) -> Bool {
    let result = str.compare("")
    
    if result == NSComparisonResult.OrderedSame {
        return true
    }
    
    return false
}

strIsEmpty("")




func verIsNeedUpdate(newVer: String) -> Bool {
    
    let mainBundle = NSBundle.mainBundle()
    
//    bundleURL = mainBundle.bundleURL
//    mainBundle.bundlePath
    
    let appVer:AnyObject? = mainBundle.objectForInfoDictionaryKey("CFBundleShortVersionString")
    print("curren ver: \(appVer)")
    
    let result = appVer?.caseInsensitiveCompare(newVer)
    if result == NSComparisonResult.OrderedAscending {
        return true
    }
    return false
}


verIsNeedUpdate("1.2")






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
//获取屏幕大小（不包括状态栏高度）
func deviceApplictionFrame() -> CGRect {
    return UIScreen.mainScreen().applicationFrame
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

//获取推送token
//APP名称
func appName() -> String {
    let mainBundle = NSBundle.mainBundle()
    
    let str:AnyObject? = mainBundle.objectForInfoDictionaryKey("CFBundleDisplayName")
    
    return (str) as! String
}

//APP应用版本
func appVersion() -> String {
    let mainBundle = NSBundle.mainBundle()
    
    let str:AnyObject? = mainBundle.objectForInfoDictionaryKey("CFBundleShortVersionString")
    
    return (str) as! String
}

//APP应用build版本
func appBuildVersion() -> String {
    let mainBundle = NSBundle.mainBundle()
    
    let str:AnyObject? = mainBundle.objectForInfoDictionaryKey("CFBundleVersion")
    
    return (str) as! String
}

//获取手机语言
//获取国家

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}



struct Rect {
    var origin = Point()
    var size   = Size()
    
    var center: Point {
        get {
            let centerX = origin.x + (size.height / 2)
            let centerY = origin.y + (size.width / 2)
            return Point(x: centerX, y: centerY)
        }
        set (newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var newRect = Rect (origin: Point(x: 10, y: 10), size: Size(width: 5, height: 5))

var count = 0
func incrementBy (amount : Int) {
    count += amount
}

incrementBy(10)

var welcomeMessage: String
welcomeMessage  = "Hello"

var red, green, blue: Double


var friendlyWelcome = "Hello"
print(friendlyWelcome)
print("The current value of friendlyWelcome is \(friendlyWelcome)")

let cat = "cat"; print(cat)


struct  TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")


var numberOfLegs = ["spider":8, "ant":6, "cat":4]
numberOfLegs["bird"] = 2
print(numberOfLegs)

numberOfLegs.removeValueForKey("loin")
print(numberOfLegs)

let testa = "aaa"
//let testb = testa
let testb = "aaa"

if testa == testb {
    print("a===b")
}






















