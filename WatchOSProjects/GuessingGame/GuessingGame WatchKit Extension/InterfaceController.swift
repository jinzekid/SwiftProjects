//
//  InterfaceController.swift
//  GuessingGame WatchKit Extension
//
//  Created by YangLu on 16/6/25.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var guessValue: WKInterfaceSlider!
    @IBOutlet var guessLabel: WKInterfaceLabel!
    @IBOutlet var guessButton: WKInterfaceButton!
    
    var yourGuess: Int = 1
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        updateGuess(info:"Your Guess is: \(yourGuess)", color: UIColor.yellowColor())
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateGuess(info info: String, color: UIColor) {
        guessLabel.setText(info)
        guessLabel.setTextColor(color)
    }

    @IBAction func updateGuess(value: Float) {
        yourGuess = Int(value)
        updateGuess(info:"Your Guess is: \(yourGuess)", color: UIColor.yellowColor())
    }
    
    @IBAction func showGuess() {
        let computersGuess = Int(arc4random_uniform(11))
        
        if yourGuess == computersGuess {
            updateGuess(info:"Your're Correct. Good Job!", color: UIColor.greenColor())
        } else {
            updateGuess(info:"Wrong. The number is \(computersGuess)", color: UIColor.redColor())
        }
    }
}
