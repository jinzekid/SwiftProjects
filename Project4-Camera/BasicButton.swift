//
//  BasicButton.swift
//  EVOPSwift
//
//  Created by apple on 6/7/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class BasicButton: UIButton {

    typealias actionHandler = () -> Void
    var handler: actionHandler?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
    }
    
    func initButtonHandler(ahandler: actionHandler?) {
        self.handler = ahandler
    }
    
    func buttonAction () {
        guard let aHandler = self.handler else {
            print("No handler")
            return
        }
        aHandler()
    }
}

extension UIButton {
    func initParameters(bgColor abgColor: UIColor, textColor atColor: UIColor, buttonRadius abRaduis: CGFloat) {
        self.backgroundColor = abgColor
        self.titleLabel?.textColor = atColor
        self.layer.cornerRadius = abRaduis
    }
}
