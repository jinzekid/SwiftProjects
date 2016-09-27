//
//  CFilterExtension.swift
//  CoreImageSwift
//
//  Created by apple on 6/22/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import Foundation
import CoreImage

// MARK: - CIFilter's extensions
extension CIFilter {
    // CICategoryBlur
    // BoxBlur: radius=10.00,
    // CIDiscBlur:  radius=8.00,
    // CIGaussianBlur: radius= 10.00
    // CIMaskedVariableBlur: radius = 10.00, mask: ciimage
    func initInput(ciImage image: CIImage) {
        self.setValue(image, forKey: "inputImage")
    }
    
    func adjust(radius aRadius: Float) {
        // 值越大越模糊
        // 到1000基本上就看不出来了
        self.setValue(NSNumber(value: aRadius), forKey: "inputRadius")
    }
    
    func adjust(radius value: Float, maskCIImage mask: CIImage) {
        self.adjust(radius: value)
        self.setValue(mask, forKey: "inputMask")
    }
    
    // HueAdjust, BoxBlur
    // 只需要inputImage的filter：
    // CILinearToSRGBToneCurve,CISRGBToneCurveToLinear
    func adjust(angle anAngle: Float ) {
        self.setValue(NSNumber(value: anAngle*Float(2*M_PI)), forKey: "inputAngle")
    }
    
    func adjust(value newValue: Float) {
        if (self.name == "CIBoxBlur") {
            self.adjust(radius: newValue)
        } else if (self.name == "CIHueAdjust") {
            self.adjust(angle: newValue)
        }
    }
}
