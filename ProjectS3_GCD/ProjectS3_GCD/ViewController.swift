//
//  ViewController.swift
//  ProjectS3_GCD
//
//  Created by apple on 6/23/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        testThread()
//        self.perform(#selector(testDeatchNewThread), with: nil, afterDelay: 3.0)
//        testDeatchWithParamNewThread()
        
//        gcdTestDifferentSerialQueue()
//        gcdCustomQueueAsyncTest()
//        gcdDispatchWorkItemTest()
        gcdDispatchGroupTest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Thread test
    func test() {
        print("I'm test...,thread==\(Thread.current())")
    }
    
    func testWithParam(obj: AnyObject) {
        print("I'm test...,thread==\(Thread.current()),param==\(obj)")
    }
    
    func testThread() {
        let thread = Thread(target: self, selector: #selector(test), object: nil)
        thread.start()
    }
    
    func testDeatchNewThread() {
        Thread.detachNewThreadSelector(#selector(test), toTarget: self, with: nil)
    }
    
    func testDeatchWithParamNewThread() {
        Thread.detachNewThreadSelector(#selector(testWithParam(obj:)), toTarget: self, with: "with param")
    }
    
    
    // 对于串行队列的sync方法
    // 这个结果是一个串行结果
    func gcdGlobalQueueSyncTest() {
        let globalQueue = DispatchQueue.global()
        globalQueue.sync {
            for i in 1...5 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        globalQueue.sync {
            for i in 6...10 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        globalQueue.sync {
            for i in 11...15 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
    }
    
    // 生成3个serial类型的queue
    // 只要是sync执行的话就是顺序执行
    func gcdGlobalQueueDifferentQueueSyncTest() {
        let globalQueue = DispatchQueue.global(attributes: .qosDefault)
        let myQueue1 = newQueue(name: "MyQueue1", queue: globalQueue, attributes: .serial)
        let myQueue2 = newQueue(name: "MyQueue2", queue: globalQueue, attributes: .serial)
        let myQueue3 = newQueue(name: "MyQueue3", queue: globalQueue, attributes: .serial)
        myQueue1.sync {
            for i in 1...5 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        myQueue2.sync {
            for i in 6...10 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        myQueue3.sync {
            for i in 11...15 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
    }
    
    // 对于串行队列的async方法
    // 并行执行并且在不同的线程中
    func gcdGlobalQueueAsyncTest() {
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            for i in 1...5 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        globalQueue.async {
            for i in 6...10 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        globalQueue.async {
            for i in 11...15 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
    }

    // 生成3个serial类型的queue
    // 只要是async就并发执行
    func gcdGlobalQueueDifferentQueueAsyncTest() {
        let globalQueue = DispatchQueue.global(attributes: .qosDefault)
        let myQueue1 = newQueue(name: "MyQueue1", queue: globalQueue, attributes: .serial)
        let myQueue2 = newQueue(name: "MyQueue2", queue: globalQueue, attributes: .serial)
        let myQueue3 = newQueue(name: "MyQueue3", queue: globalQueue, attributes: .serial)
        myQueue1.async {
            for i in 1...5 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        myQueue2.async {
            for i in 6...10 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        myQueue3.async {
            for i in 11...15 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
    }
    
    // 自定义queue一样同样
    // 如果使用async就是并行执行；使用concurrent属性，会在不同的线程中运行(也可能会2个方法在同一个线程中运行但还是并行)
    // 如果使用sync就是串行执行；如果是.serial的话也是顺序执行并且在统一线程中
    func gcdCustomQueueAsyncTest() {
        let customQueue = DispatchQueue.init(label: "aCustomConcurrentQueue", attributes: DispatchQueueAttributes.concurrent)
        customQueue.async {
            for i in 1...5 {
                print("i == \(i), thread == \(Thread.current()), label == \(customQueue.label)")
            }
        }
        customQueue.async {
            for i in 6...10 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        customQueue.async {
            for i in 11...15 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        print("main thread:\(DispatchQueue.main)")
    }
    
    // Create a Disptach Queue to which you submit work
    // Dispatch Queues execute work items in FIFO order
    // Use .async to execute your work on the queue
    // Chooing the right number of queues to use is important
//    func gcdCustomDispatchQueue() {
//        let queue = DispatchQueue(label: "com.example.imagetranform")
//        queue.sync { 
//            let smallImage = image.resize(to: rect)
//            
//            DispatchQueue.main.async(execute: { 
//                imageView.image = smallImage
//            })
//        }
//    }
    
    // Chooing a Quality of Service
    // User Interactive
    // User Initiated
    // Utility
    // Background
    // User .async to submit work with a specific Qos class
    // Dispatch helps resolve priority inversions
    // Create single-purpose queues with a specific QoS class
    func gcdQualityServiceTest() {
        let queue = DispatchQueue(label: "QualityService")
        
        queue.async(qos: .background) {
            print("Maintenance work")
        }
        
        queue.async(qos: .userInitiated) {
            print("Button tapped")
        }
    }
    
    // DispatchWorkItem
    // Create DispatchWorkItem form closures to control execution properties
    // Use .assignCurrentContext to capture current QoS at time of creation
    let item = DispatchWorkItem(flags: .assignCurrentContext) {
        print("Hello WWDC 2016!")
    }
    
    func gcdDispatchWorkItemTest() {
         let customQueue = DispatchQueue.init(label: "aCustomConcurrentQueue")
        customQueue.async(execute: item)
    }
    
    func gcdDispatchGroupTest() {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "GroupQueue", attributes: .concurrent)
        dispatch
        group.notify(queue: queue) { 
            for i in 1...5 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        group.notify(queue: queue) {
            for i in 6...10 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }
        group.notify(queue: queue) {
            print("I'm notify....");
        }
        group.notify(queue: queue) {
            for i in 11...15 {
                print("i == \(i), thread == \(Thread.current())")
            }
        }

        
        
        
    }
}


//// Use Explicit Synchronization
//class MyObject {
//    private var internalState: Int = 0
//    private let internalQueue: DispatchQueue
//    
//    var state: Int {
//        get {
//            return internalQueue.sync { internalState }
//        }
//        set (newState) {
//            internalQueue.sync { internalState = newState }
//        }
//    }
//}
