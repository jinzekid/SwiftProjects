//
//  FontUtility.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/12/8.
//  Copyright © 2015年 JasonLu. All rights reserved.
//

import Foundation
import UIKit

// MARK: -计算String在指定宽度中的高度
/**
 计算String在指定宽度中的高度
 
 - parameter font:          当前字体
 - parameter content:       当前内容
 - parameter bound:         当前范围
 - parameter lineBreakMode: 换行格式
 
 - example:
 测试实例：
 let string = "fdjsaflkdsjajklfjs专家房价疯狂的设计开发力度房间看电视就分开了"
 let size = contentSize(UIFont(name: "HelveticaNeue-Light", size: 13)!, content: string, bound:CGSizeMake(200, 100), lineBreakMode: NSLineBreakMode.ByWordWrapping)
 
 - returns: 字符串的大小
 */
func contentSize(font: UIFont , content: String , bound:CGSize , lineBreakMode:NSLineBreakMode) -> CGSize {
    
    // 有两种方法
    //
    //   let options = unsafeBitCast(NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
    //   NSStringDrawingOptions.UsesFontLeading.rawValue,
    //   NSStringDrawingOptions.self)

    let options: NSStringDrawingOptions = .UsesLineFragmentOrigin
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = lineBreakMode//.ByCharWrapping//lineBreakMode;//
    
    let attributes = [NSFontAttributeName:font,
                      NSParagraphStyleAttributeName:paragraphStyle.copy()]
    let boundingRect = content.boundingRectWithSize(bound, options: options, attributes:attributes, context:nil)
    
    return boundingRect.size
}

// MARK: -检查font的方法
/**
 检查font的方法
 */
func systemSupprotFont () {
    for name in UIFont.familyNames() {
        print(name)
        if let nameString: String? = name {
            print("Support Font:\(UIFont.fontNamesForFamilyName(nameString!))")
        }
    }
}


// MARK: -创建自定义的attributed字符串
/**
 创建自定义的attributed字符串
 
 - parameter arr:       字符串信息，字符串信息格式:@{@"String":@"",@"Font":UIFont,@"Color":UIColor}
 - parameter alignment: 字符排序方式
 - parameter space:     间距
 - parameter sepStr:    分隔符
 
 - returns: 自定义的字符串
 */
func createCustomAttributedString(infoArr arr:NSArray , textAlignment alignment:NSTextAlignment , lineSpace space:CGFloat , sepeatorString sepStr:String) -> NSAttributedString {
    
    let mStr = NSMutableString()
    let count = arr.count
    
    arr.enumerateObjectsUsingBlock { (obj, idx, NULL) -> Void in
        let str = obj["String"] as! String
        if idx >= count {
            mStr.appendFormat("%@", str)
        } else {
            mStr.appendFormat("%@%@", str , sepStr)
        }
    }
    
    let attributedString = NSMutableAttributedString.init(string: mStr as String)
    let paragraphStyle = NSMutableParagraphStyle.init()
    paragraphStyle.alignment = alignment
    paragraphStyle.lineSpacing = space
    attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, mStr.length))
    
    let nsstring = NSString.init(string: sepStr)
    let sepeatorLength = nsstring.length
    var startIndex = 0
    arr.enumerateObjectsUsingBlock { (obj , idx, NULL) -> Void in
        let str = obj["String"] as! NSString
        let font = obj["Font"] as! UIFont
        let color = obj["Color"] as! UIColor
        
        let length = str.length
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(startIndex , length))
        attributedString.addAttribute(NSFontAttributeName, value: font , range: NSMakeRange(startIndex , length))
        startIndex += (length + sepeatorLength)
    }
    
    return attributedString
}


func createFont(name: String , size: CGFloat) -> UIFont {
    return UIFont.init(name: name, size: size)!
}