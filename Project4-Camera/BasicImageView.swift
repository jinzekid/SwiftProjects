//
//  BasicImageView.swift
//  Project4-Camera
//
//  Created by apple on 6/8/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit

class BasicImageView: UIImageView {

}

extension BasicImageView {
    func initParameters(radius radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}