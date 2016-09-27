//
//  ViewController.swift
//  Project12_RunLoopTest
//
//  Created by apple on 6/21/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var runLoopThreadDidFinishFlag = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.handleRunLoopThreadButtonTouchUpInside()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("main thread: \(pthread_main_np())")
        print("nsthread main thread:\(Thread.main)")
        
//        print("run loop main:\(CFRunLoopGetMain())")
//        print("run current:\(CFRunLoopGetCurrent())")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleRunLoopThreadButtonTouchUpInside() {
        self.runLoopThreadDidFinishFlag = false
        
        let runLoopThread = Thread.init(target: self, selector: #selector(handleRunLoopThreadTask), object: nil)
        runLoopThread.start()
        
        while self.runLoopThreadDidFinishFlag == false {
            print("Begin RunLoop")
            
            RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode, before: Date.distantFuture)
            print("End RunLoop")
        }
        
        print("Exit handleRunLoopThreadButtonTouchUpInside")
    }
    
    func handleRunLoopThreadTask() {
        print("Enter Run Loop Thread")
        
        for i in 0..<5 {
            print("In Run Loop Thread, count = \(i)")
            sleep(1)
        }
        
        #if false
            self.runLoopThreadDidFinishFlag = true
        #else
            self.performSelector(onMainThread: #selector(updateRunLoopThreadDidFinishFlag), with: nil, waitUntilDone: false)
        #endif
        
        print("Exit Run Loop Thread")
    }
    
    func updateRunLoopThreadDidFinishFlag() {
        self.runLoopThreadDidFinishFlag = true
    }

}

