//
//  InterfaceController.swift
//  WatchTracker WatchKit Extension
//
//  Created by YangLu on 16/6/25.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation
import WatchConnectivity

class InterfaceController: WKInterfaceController, CLLocationManagerDelegate, WCSessionDelegate {

    @IBOutlet var mapView: WKInterfaceMap!;
    @IBOutlet var mapZoom: WKInterfaceSlider!
    
    private let locationManager = CLLocationManager()
    private var lastFoundLocation: CLLocation?
    private var session: WCSession?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Start the WatchKit Connectivity Session
        startWatchKitSession()
        
        // Configure interface objects here.
        self.mapView.removeAllAnnotations()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        handleLocationServicesAuthorizationStatus(authorizationStatus)
        
        if let lastUpdatedLocation = lastFoundLocation {
            queryWatchTrackerForLocation(lastUpdatedLocation)
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    // MARK: -CLLocationManager Delegate 
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get our current location that has been determined
        print("Did update Locations: \(locations)")
        guard let mostRecentLocation = locations.last else { return }
        queryWatchTrackerForLocation(mostRecentLocation)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        if error.code == CLError.LocationUnknown.rawValue { return }
        print("Failed to get a valid location: \(error)")
    }
    
    // MARK: -WCSession Delegate 
    private func startWatchKitSession() {
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session?.delegate = self
            session?.activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        print("WatchKit: Received application context: (applicationContext)")
        guard let data = applicationContext["lastFoundLocation"] as? NSData else { return }
        guard let location = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? CLLocation else { return }
        queryWatchTrackerForLocation(location)
    }
    
    // MARK: -Utility Methods
    @IBAction func handleMapZooming(value: Float) {
        let degrees: CLLocationDegrees = CLLocationDegrees(value) / 10
        let span = MKCoordinateSpanMake(degrees, degrees)
        let region = MKCoordinateRegionMake((lastFoundLocation?.coordinate)!, span)
        mapView.setRegion(region)
    }
    
    // Method is called to check if we can access our location services
    func handleLocationServicesAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined:
            locationManager.requestAlwaysAuthorization()
        case .Restricted, .Denied:
            print("Locations Disable\n\nEnable locations for this app via the Settings in your iPhone.")
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            locationManager.requestLocation()
        }
    }
    
    func didLocationDistanceChange(updateLocation: CLLocation) -> Bool {
        guard let lastUpdateLocation = lastFoundLocation else {
            return true
        }
        let distance = lastUpdateLocation.distanceFromLocation(updateLocation)
        return distance > 400
    }
    
    private func queryWatchTrackerForLocation(location: CLLocation) {
        // Check to see if our distance has changed
        if didLocationDistanceChange(location) == false {
            return
        }
        
        // Store our current location for next time round.
        print("WatchKit: Current locatin has been changed.")
        lastFoundLocation = location
        
        // Get our Coordinate for the location
        let coordinate = location.coordinate
        mapView.addAnnotation(coordinate, withPinColor: .Red)
        
    }
    
}
