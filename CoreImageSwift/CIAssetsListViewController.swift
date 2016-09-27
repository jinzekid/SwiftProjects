//
//  CIAssetsListViewController.swift
//  CoreImageSwift
//
//  Created by YangLu on 16/2/25.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import UIKit
import Photos

class CIAssetsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {//PHPhotoLibraryChangeObserver {

    // MARK: - IBOutlets
    @IBOutlet weak var contentTableView: UITableView!
    
    // MARK: - Properties
    let AllPhotosReuseIdentifier = "CustomCell"//"AllPhotosCell"
    let CollectionCellReuseIdentifier = "CustomCell";
    
    var sectionFetchResults = [AnyObject]()
    var sectionLocalizedTitles = [String]()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableView()
//        initPH()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionFetchResults.count
    }

    #if swift(>=2.3)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var numberOfRows = 0
        if section == 0 {
            numberOfRows = 1
        }
        else {
            let fetchResult = self.sectionFetchResults[section]
            numberOfRows = fetchResult.count
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CustomCell?
        if (indexPath as NSIndexPath).section == 0 {
//            cell = tableView.dequeueReusableCellWithIdentifier(AllPhotosReuseIdentifier, forIndexPath: indexPath)
            cell = filterInfoCell(tableView, indexPath: indexPath)
            if cell  != nil {
                cell!.titleLabel.text = NSLocalizedString("All Photos", comment: "")
            }
        }
        else {
            let fetchResult = self.sectionFetchResults[(indexPath as NSIndexPath).section]
//            let collection = fetchResult[indexPath.row] as! PHCollection
            
            //            cell = tableView.dequeueReusableCellWithIdentifier(CollectionCellReuseIdentifier, forIndexPath: indexPath)
            //            cell?.textLabel!.text = collection.localizedTitle
            
            cell = filterInfoCell(tableView, indexPath: indexPath)
//            if cell != nil {
//                cell!.titleLabel.text = collection.localizedTitle
//            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionLocalizedTitles[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
    }
    #else
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var numberOfRows = 0
        if section == 0 {
            numberOfRows = 1
        }
        else {
            let fetchResult = self.sectionFetchResults[section]
            numberOfRows = fetchResult.count
        }
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell {
        var cell: CustomCell?
        if (indexPath as NSIndexPath).section == 0 {
            //            cell = tableView.dequeueReusableCellWithIdentifier(AllPhotosReuseIdentifier, forIndexPath: indexPath)
            cell = filterInfoCell(tableView, indexPath: indexPath)
            if cell  != nil {
                cell!.titleLabel.text = NSLocalizedString("All Photos", comment: "")
            }
        }
        else {
            let fetchResult = self.sectionFetchResults[(indexPath as NSIndexPath).section]
            //            let collection = fetchResult[indexPath.row] as! PHCollection
            
            //            cell = tableView.dequeueReusableCellWithIdentifier(CollectionCellReuseIdentifier, forIndexPath: indexPath)
            //            cell?.textLabel!.text = collection.localizedTitle
            
            cell = filterInfoCell(tableView, indexPath: indexPath)
            //            if cell != nil {
            //                cell!.titleLabel.text = collection.localizedTitle
            //            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionLocalizedTitles[section]
    }
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as NSIndexPath, animated: false)
    }
    #endif
    
//    //MARK: - PHPhotoLibraryChangeObserver
//    func photoLibraryDidChange(_ changeInstance: PHChange) {
//        DispatchQueue.main.async { () -> Void in
//            var updateSectionFetchResults = Array.init(self.sectionFetchResults)
//            var reloadRequired = false
//        
//            for (index , collectionFetchResult) in self.sectionFetchResults.enumerated() {
//                let changeDetails = changeInstance.changeDetails(for: collectionFetchResult as! PHFetchResult)
//                
//                if changeDetails != nil {
//                    updateSectionFetchResults[index] = changeDetails!.fetchResultAfterChanges
//                    reloadRequired = true
//                }
//            }
//            
//            if reloadRequired == true {
//                self.sectionFetchResults = updateSectionFetchResults
//                self.contentTableView.reloadData()
//            }
//            
//        }
//    }

    // MARK: - Utility Methods
    #if swift(>=2.3)
    func filterInfoCell(_ tableView: UITableView, indexPath: IndexPath) -> CustomCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllPhotosReuseIdentifier) as? CustomCell
//        cell!.titleLabel.text = filterNameAtIndex(indexPath.row)
        return cell
    }
    #else
    func filterInfoCell(tableView: UITableView, indexPath: NSIndexPath) -> CustomCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier(AllPhotosReuseIdentifier) as? CustomCell
        return cell
    }
    #endif
    
    func updateTableView() {
        self.contentTableView.delegate     = self
        self.contentTableView.dataSource = self
        #if swift(>=2.3)
        self.contentTableView.register(UINib(nibName:AllPhotosReuseIdentifier, bundle: nil), forCellReuseIdentifier: AllPhotosReuseIdentifier)
        #else
        self.contentTableView.registerNib(UINib(nibName:AllPhotosReuseIdentifier, bundle: nil), forCellReuseIdentifier: AllPhotosReuseIdentifier)
        #endif
    }
    
//    func initPH() {
//        let allPhotoOptions = PHFetchOptions.init()
//        allPhotoOptions.sortDescriptors?.append( SortDescriptor.init(key: "creationDate", ascending: true))
//        let allPhotos = PHAsset.fetchAssets(with: allPhotoOptions)
//        
//       let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
//        
//        print("topLevelUserCollections==\(topLevelUserCollections)")
//        for i in 0..<topLevelUserCollections.count {
//            let onePHFetchResult = topLevelUserCollections.object(at: i) as! PHAssetCollection
//            print(onePHFetchResult)
//            print(onePHFetchResult.estimatedAssetCount)
//            
////            let fetchOptions = PHFetchOptions.init()
////            fetchOptions.includeAllBurstAssets = true
////            let result = PHAssetCollection.fetchAssetCollectionsWithType(onePHFetchResult.assetCollectionType, subtype: onePHFetchResult.assetCollectionSubtype, options: nil)
////            print("one PHAsset==\(result.count)")
//            
//            let assetsFetchResult = PHAsset.fetchAssets(in: onePHFetchResult, options: nil)
//            print(assetsFetchResult.count)
////            print("\(onePHFetchResult.localizedTitle:\(assetsFetchResult.count))")
//            
////            // Configure the AAPLAssetGridViewController with the asset collection.
////            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
////            PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
////            
////            assetGridViewController.assetsFetchResults = assetsFetchResult;
////            assetGridViewController.assetCollection = assetCollection;
//            
//            
//            
//        }
//        
//        self.sectionFetchResults.append(allPhotos)
//        self.sectionFetchResults.append(topLevelUserCollections)
//        
//        self.sectionLocalizedTitles.append(NSLocalizedString("All Photos", comment: ""))
//        self.sectionLocalizedTitles.append(NSLocalizedString("Albums", comment: ""))
//
//        PHPhotoLibrary.shared().register(self)
//    }
}
