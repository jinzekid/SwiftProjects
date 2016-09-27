//: Playground - noun: a place where people can play

import UIKit

//let arr = NSArray()
//
//var stringArr: Array = [String]()
//stringArr.append("111")
//stringArr.append("222")
//
//var stringArr2 = stringArr
//stringArr2[1] = "333"
//stringArr
//stringArr2
//
//var dic1 = Dictionary<String, AnyObject>()
//var dic2: [String: AnyObject] = Dictionary()
//var dic3: [String: AnyObject] = [:]
//var dic4 = [String: AnyObject]()
//
//#if swift(>=2.3)
//    print("\(stringArr)")
//#else
//    print("\(stringArr2)")
//#endif
//
//// MAKR: - CESHI
//
//let path = "http://www.asmtechnology.com/MathService/CircleArea/?radius=10"
//let url = URL(string: path)!//NSURL(string: path)!
//let data = try Data(contentsOf: url as URL) //NSData(contentsOfURL: url as URL)
//let JSONObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//JSONObject["status"]
//
//enum JSONError: ErrorProtocol {
//    case jsonDataError
//}
//
//extension Data {
//    func toJSON() -> AnyObject {
//        let JSONObject = try! JSONSerialization.jsonObject(with: self, options: .mutableContainers)
//        return JSONObject
//    }
//}
//
//extension Data {
//    /**
//     数据转换
//     - returns: 返回对应的NSDictionary
//     */
//    func toDictionary() -> NSDictionary? {
//        var dic: NSDictionary?
//        do {
//            dic = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? NSDictionary
//        } catch {
//            print("Error")
//            return nil
//        }
//        return dic
//    }
//}
//
//let result = data.toJSON()
//result["message"]
//
//let dic = data.toDictionary()
//
//var data1: AnyObject? = nil
//let dataToDic = data.toDictionary()
//let dataToJSON = data.toJSON()
//if let message = dataToDic!["message"] {
//        print("messag: \(message)")
//}
//dataToJSON["status"]
//
//var a = 10
//let test = {
//    a = 100
//    print("a: \(a)")
//}
//test()
//print("after test a: \(a)")
//
//if nil == .none {
//    print("it's nil")
//}

func curried(_ x: Int) -> (String) -> Float {
    return {
        (y: String) -> Float in
        return Float(x) + Float(y)!
    }
}

let r = curried(10)
let rr2 = r("20")


var a = 19
var b = 29
a ^= b
b ^= a
a ^= b

let age = 3
assert(age >= 0, "A person's age cannot be less than zero")

////1.创建NSBlockOperation对象
//let operation = NSBlockOperation { () -> Void in
//    NSLog("%@", NSThread.currentThread())
//}
//
////2.添加多个Block
//for i in 0..<5 {
//    operation.addExecutionBlock { () -> Void in
//        NSLog("第%ld次 - %@", i, NSThread.currentThread())
//    }
//}
//
////2.开始任务
//operation.start()

////1.创建其他队列
//let queue = NSOperationQueue()
//
////2.创建NSBlockOperation对象
//let operation = NSBlockOperation { () -> Void in
//    NSLog("%@", NSThread.currentThread())
//}
//
////3.添加多个Block
//for i in 0..<5 {
//    operation.addExecutionBlock { () -> Void in
//        NSLog("第%ld次 - %@", i, NSThread.currentThread())
//    }
//}
//
////4.队列添加任务
//queue.addOperation(operation)

//1.任务一：下载图片
let operation1 = NSBlockOperation { () -> Void in
    NSLog("下载图片 - %@", NSThread.currentThread())
    NSThread.sleepForTimeInterval(1.0)
}

//2.任务二：打水印
let operation2 = NSBlockOperation { () -> Void in
    NSLog("打水印  - %@", NSThread.currentThread())
    NSThread.sleepForTimeInterval(1.0)
}

//3.任务三：上传图片
let operation3 = NSBlockOperation { () -> Void in
    NSLog("上传图片 - %@", NSThread.currentThread())
    NSThread.sleepForTimeInterval(1.0)
}

//4.设置依赖
operation2.addDependency(operation1)    //任务二依赖任务一
operation3.addDependency(operation2)    //任务三依赖任务二

//5.创建队列并加入任务
let queue = NSOperationQueue()
queue.addOperations([operation3, operation2, operation1], waitUntilFinished: false)











