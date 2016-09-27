//
//  ViewController.swift
//  Project_CBTransferApp
//
//  Created by apple on 6/30/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate {

    @IBOutlet weak var bluetoothStateLabel: UILabel!
    var centralManager: CBCentralManager!
    var isBluetoothPoweredOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case .PoweredOn:
            bluetoothStateLabel.text = "Bluetooth ON"
            bluetoothStateLabel.textColor = UIColor.greenColor()
        case .PoweredOff:
            bluetoothStateLabel.text = "Bluetooth OFF"
            bluetoothStateLabel.textColor = UIColor.redColor()
        default:
            break;
        }
    }

}

