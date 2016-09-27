//
//  StringExtension.swift
//  CoreImageSwift
//
//  Created by apple on 6/22/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import Foundation

extension String {
    func buttonName() -> String {
        switch self {
        case "CIBoxBlur":
            return "模糊"
        default:
            return ""
        }
    }
}
