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
        #if swift(>=2.3)
        self.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        #else
        self.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        #endif
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initButtonHandler(_ ahandler: actionHandler?) {
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
    func buttonStyle(bgColor abgColor: UIColor, textColor atColor: UIColor, buttonRadius abRaduis: CGFloat) {
        self.backgroundColor = abgColor
        self.titleLabel?.textColor = atColor
        self.layer.cornerRadius = abRaduis
        self.layer.masksToBounds = true
    }
    
    func buttonImage(normal imageForNormal: UIImage?, highlight imageForHighlight: UIImage?) {
        #if swift(>=2.3)
        self.setBackgroundImage(imageForNormal, for: UIControlState())
        self.setBackgroundImage(imageForHighlight, for: .highlighted)
        #else
        self.setBackgroundImage(imageForNormal, forState: .Normal)
        self.setBackgroundImage(imageForHighlight, forState: .Highlighted)
        #endif
    }
}
