//
//  Person.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/12/9.
//  Copyright © 2015年 JasonLu. All rights reserved.
//

import Foundation

class Person {
    let name: String
    private var actionClosure: (() -> ())!
    
    init(name: String ) {
        self.name = name
        
        actionClosure = {
            [unowned self] () -> () in
            print("I am \(self.name)")
        }
    }
    
    func performAction() {
        actionClosure()
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
  
  func description()  {
    print("my name is \(name)")
  }
}


