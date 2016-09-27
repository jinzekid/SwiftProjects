//
//  ImageUtility.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/12/28.
//  Copyright © 2015年 JasonLu. All rights reserved.
//
/*!
图片处理以及摄像头的使用
*/

import Foundation
import UIKit


func isAvaliableCamera () -> Bool {
    if UIImagePickerController.isSourceTypeAvailable(.Camera) {
        return true
    }
    return false
}

func isAvaliableFrontCamera () -> Bool {
    if UIImagePickerController.isCameraDeviceAvailable(.Front) {
        return true
    }
    return false
}

func isAvaliableRearCamera () -> Bool {
    if UIImagePickerController.isCameraDeviceAvailable(.Rear) {
        return true
    }
    return false
}

