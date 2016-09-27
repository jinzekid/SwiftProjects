//
//  Student.swift
//  StudyNote
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import Foundation

class Student {
    let name: String
    let age  : NSInteger
    let gender: Bool
    
    init(name: String , age: NSInteger , gender:Bool) {
        self.name = name
        self.age    = age
        self.gender = gender
    }
    
}