//
//  ViewController.swift
//  SwiftUtilityProject
//
//  Created by JasonLu on 15/11/16.
//  Copyright © 2015年 JasonLu. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var taxPctSlider: UISlider!
    @IBOutlet weak var taxPctLabel: UILabel!
    @IBOutlet weak var resultsTextView: UITextView!
    let tipCalc = TipCalculator(total: 33.25, taxPct: 0.06)
    
    @IBOutlet weak var tableView: UITableView!
    typealias tipAndTotalNamed = (tipAmt: Double , total: Double)
    var possibleTips = Dictionary<Int , tipAndTotalNamed>()
    var sortedKeys:[Int] = []
    
    func refreshUI () {
        totalTextField.text = String(format: "0.2f", tipCalc.total)
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        taxPctLabel.text    = "Tex Percentage (\(Int(taxPctSlider.value))%)"
//        resultsTextView.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = Person(name: "bob")
        person.performAction()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
//        let key = "test"
//        saveNotification(key, value: "111")
//        let value = loadNotification(key)
//        print("value is: \(value)")
        
//        let person = Person(name: "bob")
//        person.performAction()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func calculateTapped(sender: AnyObject) {
        tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = Array(possibleTips.keys).sort()
        tableView.reloadData()
        
        
//        tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
//        let possibleTips = tipCalc.returnPossibleTips()
//        var results = ""
//        
//        
////        for(tipPct, tipValue) in possibleTips {
////            results += "\(tipPct)%: \(tipValue)\n"
////        }
//        // 排序
//        var keys = Array(possibleTips.keys)
////        keys.sortInPlace { (one, two) -> Bool in
////            return one < two
////        }
//        keys.sortInPlace()
//        for tipPct in keys {
//            let tipValue = possibleTips[tipPct]!
//            let prettyTipValue = String(format: "%.2f", tipValue.tipAmt)
//            results += "\(tipPct)%: \(prettyTipValue)\n"
//        }
//        
//        resultsTextView.text = results
    }

    
    @IBAction func taxPercentageChanged(sender: AnyObject) {
    }
    

    @IBAction func viewTapped(sender: AnyObject) {
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    // 1
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        
        // 3
        let tipPct = sortedKeys[indexPath.row]
        // 4
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.total
        
        // 5
        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format:"Tip: $%0.2f, Total: $%0.2f", tipAmt, total)
        return cell
    }
    
}

