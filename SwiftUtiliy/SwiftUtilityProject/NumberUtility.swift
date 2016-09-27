//
//  NumberUtility.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/12/28.
//  Copyright © 2015年 JasonLu. All rights reserved.
//

import Foundation

// MARK: -2位数输出，从01，02，03开始
/*!
2位数输出，从01，02，03开始

- parameter number: 数字

- returns: 2位数的输出
*/
func twoDigitNumber(number: Int) -> String {
    print(String(format: "%02d",number))
    return String(format: "%02d",number)
}