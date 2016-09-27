//
//  TipCalculatorModel.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/12/9.
//  Copyright © 2015年 JasonLu. All rights reserved.
//

import Foundation


// 1
class TipCalculator {
    typealias tipAndTotalNamed = (tipAmt: Double , total: Double)
    // 2
    var total: Double
    let taxPct: Double
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
    }
    
    // 3
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    // 4
    func calcTipWithTipPct(tipPct: Double) -> tipAndTotalNamed {
        let tipAmt = subtotal  * tipPct
        let finalTotal = total + tipAmt
        
        return tipAndTotalNamed(tipAmt , finalTotal)
    }
    
    // 5
    func printPossibleTips() {
        print("15%: \(calcTipWithTipPct(0.15))")
        print("18%: \(calcTipWithTipPct(0.18))")
        print("20%: \(calcTipWithTipPct(0.20))")
    }
    
    func returnPossibleTips() -> [Int: tipAndTotalNamed] {
        let possibleTipsInferred = [0.15 , 0.18 , 0.20]
        var retval = [Int: tipAndTotalNamed]()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
}

import UIKit

class TestDataSource: NSObject , UITableViewDataSource {
    
    let tipCalc = TipCalculator(total: 33.25, taxPct: 0.06)
    var possibleTips = Dictionary<Int ,(tipAmt: Double , total: Double)>()
    var sortedKeys:[Int] = []
    
    override init() {
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = Array(possibleTips.keys).sort()
        super.init()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value2, reuseIdentifier: nil)
        
        let tipPct = sortedKeys[indexPath.row]
        
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.total

        
        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format: "Tip:$%0.2f, Total:$%0.2f", tipAmt, total)
        
        return cell
    }
}





