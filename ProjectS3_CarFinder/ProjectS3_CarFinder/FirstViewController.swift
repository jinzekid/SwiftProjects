//
//  FirstViewController.swift
//  ProjectS3_CarFinder
//
//  Created by apple on 6/29/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UITableViewController, CLLocationManagerDelegate{

    // MARK: -Properties
    var locationManager = CLLocationManager()
    var currentLocatoin = CLLocation()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        // 判断定位功能状态
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied:
            let alert = UIAlertController(title: "Permissions error", message: "This app needs location permission to work accuraately", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        case .notDetermined:
            fallthrough
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -TableView Delegate Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shareIntance.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        cell.tag = indexPath.row
        
        let entry : CLLocation = DataManager.shareIntance.locations[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss, MM-dd-yyyy"
        
        cell.textLabel?.text = "\(entry.coordinate.latitude), \(entry.coordinate.longitude)"
        cell.detailTextLabel?.text = dateFormatter.string(from: entry.timestamp)
        
        return cell
    }
    
    // MARK: -Utitlity Methods
    @IBAction func addLocation(_ sender: AnyObject) {
        var location: CLLocation
        
        if (CLLocationManager.authorizationStatus() != .authorizedWhenInUse) {
            location = CLLocation(latitude: 32.830579, longitude: -117.153839)
        } else {
            location = locationManager.location!
        }
        
        DataManager.shareIntance.locations.insert(location, at: 0)
        
        tableView.reloadData()
    }
    
}

