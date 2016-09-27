//
//  CIFilterManager.swift
//  CoreImageSwift
//
//  Created by YangLu on 16/2/4.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import Foundation
import UIKit

var afterEffectImage: UIImage?
var originImage: UIImage?

func createCIContext() -> CIContext {
    let context = CIContext.init()
    return context
}

// create EAGL context
// 图片的渲染在GPU,不会拷回到CPU内存中。
func createEAGLCIContext() -> CIContext {
    // 文档说关闭颜色管理器，不然会降低性能
    let options = [kCIContextWorkingColorSpace : NSNull.init()]
    
    #if swift (>=2.3)
        let eaglContext = EAGLContext(api: .openGLES2)//EAGLContext.init(api: .openGLES2)
        let myContext = CIContext.init(eaglContext: eaglContext!, options: options)
    #else
        let eaglContext = EAGLContext(API: .OpenGLES2)
         let myContext = CIContext.init(EAGLContext: eaglContext!, options: options)
    #endif
    
    return myContext
}

// 获取系统滤镜数组
func buildInFilterList() -> Array<String> {
    #if swift(>=2.3)
        return CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
    #else
        return CIFilter.filterNamesInCategory(kCICategoryDistortionEffect)
    #endif
}

func filterName(at index: NSInteger) -> String {
    return buildInFilterList()[index]
}

func buildInFilter(at index: Int) -> CIFilter {
    let filter = CIFilter(name: filterName(at: index))
    return filter!
}

func add(subView viewName: String, parentView: UIView, viewTag: Int) {
    let sView = createImageViewWithName(viewName)
    sView.tag = viewTag
    parentView.addSubview(sView)
}

func createFilter(_ name: String) -> CIFilter {
    let filter = CIFilter(name: name)
    return filter!
}

func clearSubView(_ view: UIView?, viewTag: Int)  {
    if view == nil {
        return
    }
    if let subView = view!.viewWithTag(viewTag) {
        subView.removeFromSuperview()
    }
}

func subViewWithTag(_ parentView: UIView, _ viewTag: Int) -> UIView? {
    return parentView.viewWithTag(viewTag)
}

func createImageViewWithName(_ name: String) -> UIImageView {
    return UIImageView.init(image:UIImage(named: name)!)
}

func cropped(_ image: UIImage, in rect: CGRect) -> UIImage {
    UIGraphicsBeginImageContext(rect.size)
    image.draw(at: CGPoint(x: -rect.origin.x, y: -rect.origin.y))
    let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
    return croppedImage!
}








