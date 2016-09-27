//
//  AppUtility.swift
//  Project4-Camera
//
//  Created by apple on 6/8/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import Foundation
import UIKit

// 支出摄像头
func isSupportCamera () -> Bool {
    if UIImagePickerController.isSourceTypeAvailable(.Camera) {
        return true
    }
    return false
}
