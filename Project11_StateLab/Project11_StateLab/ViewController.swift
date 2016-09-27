//
//  ViewController.swift
//  Project11_StateLab
//
//  Created by apple on 6/16/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var label: UILabel!
    private var animate = false
    private var smiley: UIImage!
    private var smileyView: UIImageView!
    private var segmentedControl: UISegmentedControl!
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bounds = view.bounds
        let labelFrame = CGRectMake(bounds.origin.x, CGRectGetMidY(bounds) - 50, bounds.size.width, 100)
        label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "Helvetica", size: 70)
        label.text = "Bazzinga!"
        label.textAlignment = .Center
        label.backgroundColor = UIColor.clearColor()
        
        let smileyFrame = CGRectMake(CGRectGetMidX(bounds) - 42, CGRectGetMidY(bounds)/2 - 42, 84, 84)
        smileyView = UIImageView(frame: smileyFrame)
        smileyView.contentMode = UIViewContentMode.Center
        let smileyPath = NSBundle.mainBundle().pathForResource("Sad", ofType: "png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
        view.addSubview(smileyView)
        view.addSubview(label)
        
        segmentedControl = UISegmentedControl(items: ["One", "Two", "Three", "Four"])
        segmentedControl.frame = CGRectMake(bounds.origin.x + 20, 50, bounds.size.width - 40, 30)
        segmentedControl.addTarget(self, action: #selector(selectionChanged(_:)), forControlEvents: .ValueChanged)
        view.addSubview(segmentedControl)
        
        index = NSUserDefaults.standardUserDefaults().integerForKey("index")
        segmentedControl.selectedSegmentIndex = index
        
        self.initAppStateNotificationInViewController()
        
    }

    func rotateLabelDown() {
        UIView.animateWithDuration(0.5, animations: { 
            self.label.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        }) { (completion: Bool) in
                self.rotateLabelUp()
        }
    }
    
    func rotateLabelUp() {
        UIView.animateWithDuration(0.5, animations: { 
            self.label.transform = CGAffineTransformMakeRotation(0)
        }) { (completion: Bool) in
            if self.animate {
                self.rotateLabelDown()
            }
        }
    }
    
    func selectionChanged(sender: UISegmentedControl) {
        index = segmentedControl.selectedSegmentIndex
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleRunLoopThreadButtonTouchUpInside() {
        let runLoopThread = NSThread.init(target: self, selector: #selector(handleRunLoopThreadTask), object: nil)
        [runLoopThread start]
        
        while()
    }
    
    func handleRunLoopThreadTask() {
        
    }
    
    // MARK: - Application State Notifications
    override func applicationWillResignActive() {
        print("VC: \(#function)")
        animate = false
    }
    
    override func applicationDidBecomeActive() {
        print("VC: \(#function)")
        animate = true
        rotateLabelDown()
    }

    override func applicationDidEnterBackground() {
        print("VC: \(#function)")
//        self.smiley = nil
//        self.smileyView.image = nil
        NSUserDefaults.standardUserDefaults().setInteger(self.index, forKey: "index")
        
        let app = UIApplication.sharedApplication()
        var taskId = UIBackgroundTaskInvalid
        let id = app.beginBackgroundTaskWithExpirationHandler({
            print("Background task ran out of time and was terminated.")
            app.endBackgroundTask(taskId)
        })
        taskId = id
        print("taskId=\(taskId), backgroundTaskInvalid=\(UIBackgroundTaskInvalid)")
        if taskId == UIBackgroundTaskInvalid {
            print("Failed to start background task!")
            return
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            print("Starting background task with " + "\(app.backgroundTimeRemaining) seconds remaining")
            
            self.smiley = nil
            self.smileyView.image = nil
            NSUserDefaults.standardUserDefaults().setInteger(random()%4, forKey: "index")
            
            NSThread.sleepForTimeInterval(25)
            
            print("Finish background task with " + "\(app.backgroundTimeRemaining) seconds remaining")
            app.endBackgroundTask(taskId)
        })
    }
    
    override func applicationWillEnterForeground() {
        print("VC: \(#function)")
        let smileyPath = NSBundle.mainBundle().pathForResource("Sad", ofType: "png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
    }

}

