//
//  ViewController.swift
//  CoreImageSwift
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    // MARK: -IBOutlets
    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var imageChangeSlider: UISlider!
    
    
    // MARK: -Properties
    var filtersListCount: Int = 0
    var selectFilterIndex: NSInteger = 0;
    var testBool: Bool = false
    var originalImage: UIImage?
     let CellIdentifierID: String = "CustomCell"
    
    
    // MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for name in buildInFilterList() {
            print("filter name:\(name)")
        }
        
        originalImage = UIImage(named: "swifticon")
        
        displayImageView.image = UIImage(named: "swifticon")
        updateOtherProperties()
        updateContentTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -Protocol Methods TableView
    #if swift(>=2.3)
    func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtersListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return filterInfoCell(tableView, indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectFilterIndex = (indexPath as NSIndexPath).row
        willChangeSlider(toValue: 0)
    }
    #else
    func numberOfSections(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtersListCount
    }
    
    func tableView(tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell {
        return filterInfoCell(tableView, indexPath: indexPath)
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: NSIndexPath) {
        selectFilterIndex = (indexPath as NSIndexPath).row
        willChangeSlider(toValue: 0)
    }
    #endif
    

    // MARK: -Utility Methods
    // 初始化列表
    func updateContentTableView() {
        #if swift(>=2.3)
        self.contentTableView.delegate = self
        self.contentTableView.dataSource = self
        self.contentTableView.register(UINib(nibName:CellIdentifierID, bundle: nil), forCellReuseIdentifier: CellIdentifierID)
        #else
        self.contentTableView.delegate = self
        self.contentTableView.dataSource = self
        self.contentTableView.registerNib(UINib(nibName:CellIdentifierID, bundle: nil), forCellReuseIdentifier: CellIdentifierID)
        #endif
    }
    
    #if swift(>=2.3)
    func filterInfoCell(_ tableView: UITableView, indexPath: IndexPath) -> CustomCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierID) as? CustomCell
        cell!.titleLabel.text = filterName(at: indexPath.row)//filterNameAtIndex((indexPath as NSIndexPath).row)
        return cell!
    }
    #else
    func filterInfoCell(tableView: UITableView, indexPath: NSIndexPath) -> CustomCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifierID) as? CustomCell
        cell!.titleLabel.text = filterName(at: indexPath.row)//filterNameAtIndex((indexPath as NSIndexPath).row)
        return cell!
    }
    #endif
    
    func updateOtherProperties() {
        filtersListCount = buildInFilterList().count
    }
    
    func willChangeSlider(toValue newValue: Float) {
        imageChangeSlider.setValue(newValue, animated: true);
    }
    
    @IBAction func imageChangeSliderAction(sender: AnyObject) {
        print("slider value==\(imageChangeSlider.value)")
        var sliderValue = imageChangeSlider.value * 10
        if testBool {
            sliderValue = 0
        }
        else {
            sliderValue = 10
        }
        
        testBool = !testBool
        
//        let ciImage = CIImage(image: displayImageView.image!)
//        var filter = buildInFilter(at: selectFilterIndex)//buildInFilterAtIndex(selectFilterIndex)
//        filter = CIFilter(name: "CIBoxBlur")!
//        filter.setValue(ciImage, forKey: kCIInputImageKey)
//        filter.setValue(NSNumber(value: sliderValue), forKey: kCIInputRadiusKey)
//        let result = filter.outputImage
//        if result != nil {
//            displayImageView.image = UIImage(ciImage: result!)
//        }
        
    }
    
//    @IBAction func changeImageEffectAction(_ sender: AnyObject) {
//        testBool = !testBool
//        if testBool {
//            displayImageView.image = originalImage
//            return
//        }
//        
//        let ciImage = CIImage(image: originalImage!)
//        var filter = buildInFilter(at: selectFilterIndex)//buildInFilterAtIndex(selectFilterIndex)
//        filter = CIFilter(name: "CIBoxBlur")!
//        filter.setValue(ciImage, forKey: kCIInputImageKey)
//        filter.setValue(NSNumber(value: 10), forKey: kCIInputRadiusKey)
//        let result = filter.outputImage
//        if result != nil {
//            displayImageView.image = UIImage(ciImage: result!)
//        }
//    }
    
    
//    func createQRWithString(_ qrString: String?, qrImageName: String?) -> UIImage? {
//        if let sureQRString = qrString {
//            let stringData = sureQRString.data(using: String.Encoding.utf8, allowLossyConversion: false)
//            
//            // 创建一个二维码de滤镜
//            let qrFilter = CIFilter(name:"CIQRCodeGenerator")!
//            qrFilter.setValue(stringData, forKey: "inputMessage")
//            qrFilter.setValue("H", forKey: "inputCorrectionLevel")
//            let qrCIImage = qrFilter.outputImage
//            
//            // 创建一个颜色滤镜，黑白色
//            let colorFilter = CIFilter(name:"CIFalseColor")!
//            colorFilter.setDefaults()
//            colorFilter.setValue(qrCIImage, forKey: "inputImage")
//            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
//            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
//            
//            // 返回二维码image
//            let codeImage = UIImage(ciImage: colorFilter.outputImage!)
//            
//            if let iconImage = UIImage(named: qrImageName!) {
//                let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
//                
//                UIGraphicsBeginImageContext(rect.size)
//                let avatarSize = CGSize(width: rect.size.width * 1, height: rect.size.height * 1)
//                let x = (rect.width - avatarSize.width) * 0.5
//                let y = (rect.height - avatarSize.height) * 0.5
//                
//                iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
//                
//                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                
//                return resultImage
//                
//            }
//            
//            return codeImage
//        }
//        return nil
//    }
    
}

