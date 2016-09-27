//
//  CustomProgressView.swift
//  Project2-CustomProgressView
//
//  Created by apple on 6/1/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import Foundation
import UIKit

extension UIProgressView {
    
    /**
     progress初始化方法
     - parameters:
        - frame: 进度条frame
        - style: 进度条类型
        - trackColor: 进度条背景颜色
        - progressCOlor:进度颜色
     */
    convenience init(frame: CGRect, style: UIProgressViewStyle, trackColor: UIColor?, progressColor: UIColor?) {
        self.init(frame: frame)
        
        self.setParam(style: style, trackColor: trackColor, progressColor: progressColor)
    }
    
    /**
     设置progress视图参数
     - parameters:
        - style: 进度条类型
        - trackColor: 进度条背景颜色
        - progressCOlor:进度颜色
     */
    func setParam(style style: UIProgressViewStyle, trackColor: UIColor?, progressColor: UIColor?) {
        self.progressViewStyle = style
        
        self.trackTintColor = trackColor
        self.progressTintColor = progressColor
    }
    
}