//
//  ViewController.swift
//  Project9_iCloudTest
//
//  Created by apple on 6/15/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var documentContentView: UITextView!
    @IBOutlet weak var serviceStatus: UILabel!
    
    var cloudServicesAreAvailable: Bool?
    var cloudDocument: SwiftCloudTestDocument?
    var searchQuery: NSMetadataQuery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        documentContentView.text = ""
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshDocumentPreview(_:)), name: "refreshDocumentPreview", object: nil)

        let containURL = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)
        
        if containURL != nil {
            self.cloudServicesAreAvailable = true
            serviceStatus.text = "Cloud Service Status: Available"
            
            loadDocument()
        } else {
            self.cloudServicesAreAvailable = false
            serviceStatus.text = "Cloud Service Status: Not Available"
            
            let alert = UIAlertController(title: "Error", message: "iCloud has not been setup on this device!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    deinit {
        if cloudDocument != nil {
            cloudDocument?.closeWithCompletionHandler(nil)
        }
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func loadDocument() {
        searchQuery = NSMetadataQuery()
        searchQuery!.searchScopes = [NSMetadataQueryUbiquitousDocumentsScope]
        
        let documentFileName = "cloudDocument.txt"
        let predicate = NSPredicate(format: "%K == %@", argumentArray: [NSMetadataItemFSNameKey, documentFileName])
        searchQuery!.predicate = predicate
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(qureyDidFinish), name: NSMetadataQueryDidFinishGatheringNotification, object: searchQuery)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        searchQuery?.startQuery()
    }
    
    func qureyDidFinish(notification: NSNotification) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        searchQuery?.disableUpdates()
        searchQuery?.stopQuery()
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSMetadataQueryDidFinishGatheringNotification, object: nil)
        
        // this application expects this query to return a single // result. If no documents were found, then create a new // document and inform the user.
        if searchQuery!.resultCount == 0 {
            let alert = UIAlertController(title: "",message: "iCloud document not found., creating new document!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true,
                                       completion: nil)
            createDocument()
            return
        }
        
        // instantiate a SwiftCloudTestDocument instance and // open the cloud document
        if cloudDocument == nil {
            let item:NSMetadataItem? = searchQuery!.results[0] as? NSMetadataItem
            if let unwrappedItem = item {
                let url = unwrappedItem.valueForAttribute(NSMetadataItemURLKey)
                    as! NSURL
                cloudDocument = SwiftCloudTestDocument(fileURL: url)
            }
        }
        
        cloudDocument!.openWithCompletionHandler { (success) -> Void in
            if (success) {
                let alert = UIAlertController(title: "", message: "iCloud document loaded!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true,
                    completion: nil)
            }
            else {
                let alert = UIAlertController(title: "", message: "Could not load iCloud document!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert,animated: true,
                    completion: nil)
            }
        }
    }

    func createDocument() {
        if self.cloudDocument == nil {
            let containerURL =
            NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)
            let documentDirectoryURL = containerURL!.URLByAppendingPathComponent("Documents")
            let documentURL = documentDirectoryURL.URLByAppendingPathComponent("cloudDocument.txt")
            cloudDocument = SwiftCloudTestDocument(fileURL: documentURL)
        }
        
        cloudDocument!.documentContents = documentContentView.text
        cloudDocument?.saveToURL(cloudDocument!.fileURL, forSaveOperation: .ForCreating, completionHandler: { (success) in
            if (success) {
                self.cloudDocument?.openWithCompletionHandler(nil)
            }
        })
    }
    
    func refreshDocumentPreview(notifcation: NSNotification) {
        documentContentView.text = cloudDocument!.documentContents;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goSave(sender: AnyObject) {
        print("go save")
        if cloudDocument == nil {
            return
        }
        
        documentContentView.resignFirstResponder()
        cloudDocument!.documentContents = documentContentView.text
        cloudDocument!.saveToURL(cloudDocument!.fileURL, forSaveOperation: UIDocumentSaveOperation.ForCreating) { (success) -> Void in
            if (success) {
                self.cloudDocument!.openWithCompletionHandler(nil)
            }
        }
    }
    

}

