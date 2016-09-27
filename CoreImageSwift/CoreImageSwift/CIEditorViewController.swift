//
//  CIEditorViewController.swift
//  CoreImageSwift
//
//  Created by YangLu on 16/2/4.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import UIKit

var startFilterTag = 1000
var selectTag: Int = 900

class CIEditorViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var editorImageView: UIImageView!
    @IBOutlet weak var valueSlider: UISlider!
    @IBOutlet weak var effectScrollView: UIScrollView!
    
    // MARK: - Properties
    var hasEffect: Bool = false
    var myContext: CIContext!
    var myFilter: CIFilter!
    var filterArr = [CIFilter]()
    var selectFilterName: String?
    var selectFilterIndex: Int = -1
    
    let mask = UIImage(named: "cicleBg")!
    var filter: CIFilter?
    
    let filterNameArr = ["CIHueAdjust","CIHueAdjust","CIHueAdjust","CIHueAdjust","CIHueAdjust","CIHueAdjust","CIHueAdjust","CIHueAdjust","CISRGBToneCurveToLinear","CILinearToSRGBToneCurve","CIBoxBlur"]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateEffectScrollView()
        initEditorImageView()
        initEffectSlider()
        myContext = createEAGLCIContext()
        
        self.valueSlider.minimumValue = 0
        self.valueSlider.maximumValue = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func recoverOriginalImageAction(_ sender: AnyObject) {
        initEditorImageView()
        initEffectSlider()
    }
    
    
    @IBAction func effectAction(sender: AnyObject) {
        if hasEffect == false {
            renderImage(withFilter: filterName(at: selectFilterIndex))
        }
        else {
            editorImageView.image = afterEffectImage
        }
        
        hasEffect = !hasEffect
    }
    
    @IBAction func didChangeSliderValueAction(_ sender: AnyObject) {
        print("valueSlider==\(valueSlider.value)")
        renderImage(withFilter: filterName(at: selectFilterIndex))
    }
    
    // MARK:  - Utility Methods
    func filterName(at index: Int) -> String {
        return filterNameArr[index]
    }
    
    func initEditorImageView() {
        afterEffectImage = originImage
        editorImageView.image = afterEffectImage
    }
    
    func initEffectSlider() {
        self.valueSlider.setValue(0, animated: false)
    }
    
    // MARK: -初始化效果列表
    func updateEffectScrollView() {
        // 获取滤镜数组
        let startX: CGFloat = 0.0
        let buttonWidth: CGFloat = 60.0
        let buttonHeight: CGFloat = 60.0
        
        let buttonSpace: CGFloat = 65.0
        
        var totalFilterCount = 0
        totalFilterCount = filterNameArr.count
        
        for (index, tmpfilterName) in filterNameArr.enumerated() {
            let filterName = tmpfilterName as String
            print("button name=\(filterName.buttonName())")
            let filter = CIFilter(name: tmpfilterName)
            filterArr.append(filter!)
            
            // 创建按钮
            let startx = (startX + buttonSpace * CGFloat(index))
            let rect = CGRect(x: startx, y: 0, width: buttonWidth, height: buttonHeight)
            let button = BasicButton(frame: rect)
            button.frame = CGRect(x: startx, y: 0, width: buttonWidth, height: buttonHeight)
            
            button.buttonStyle(bgColor: UIColor.clear(), textColor: UIColor.init(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0), buttonRadius: 0.5)
            button.setTitle(filterName.buttonName(), for: UIControlState())
            
            button.buttonImage(normal: UIImage(named: "BlueButtonBackgroundImage"), highlight: UIImage(named: "GrayButtonBackgroundImage"))
            
            button.addTarget(self, action:#selector(selectFilterButtonAction), for: .touchUpInside)
            
            button.tag = startFilterTag + index
            self.effectScrollView.addSubview(button)
        }
        
        self.effectScrollView.delegate = self
        self.effectScrollView.contentSize = CGSize(width: buttonSpace * CGFloat(totalFilterCount), height: buttonHeight)
        
    }
    
    func selectFilterButtonAction(sender: UIButton) {
        let buttonIndex = sender.tag
        let tag = buttonIndex - startFilterTag
        if selectFilterIndex != tag {
            if selectFilterIndex != -1 {
                let buttonTag = selectFilterIndex + selectTag
                let selectedButton = subViewWithTag(self.effectScrollView, buttonTag)
                clearSubView(selectedButton, viewTag: buttonTag)
            }
            
            selectFilterIndex = tag
            add(subView: "SelectShape", parentView: sender, viewTag: (selectTag + selectFilterIndex))
        }
        
        self.filter = CIFilter(name: filterName(at: selectFilterIndex))
        guard let aFilter = self.filter else { return }
        
        afterEffectImage = editorImageView.image
        aFilter.initInput(ciImage:CIImage(image: afterEffectImage!)!)
        self.valueSlider.setValue(0, animated: false)
        print("selectFilterIndex==\(selectFilterIndex)")
    }
    
    func renderImage(withFilter: String) {
        guard let aFilter = self.filter else { return }
        aFilter.adjust(value: self.valueSlider.value)
        let rect = aFilter.outputImage?.extent
        let cgImage = myContext.createCGImage(aFilter.outputImage!, from: rect!)
        let image = UIImage.init(cgImage: cgImage!)
        
        editorImageView.image = image
    }
}
