//
//  ViewController.swift
//  WatchTracker
//
//  Created by YangLu on 16/6/25.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import WatchConnectivity

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, WCSessionDelegate {

    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var lastFoundLocation: CLLocation?
    
    var session: WCSession?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Start our WatchConnectivity Session
        startWatchKitSession()
        
        // Set up our location manager properties
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
        
        switch UIDevice.currentDevice().systemVersion.compare("9.0.0", options: .NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            locationManager.requestWhenInUseAuthorization()
            // 后台开启定位，一般不需要显示
            // 在capablities中的Background modes 选择Location updates
//            locationManager.allowsBackgroundLocationUpdates = true
        default:
            locationManager.requestLocation()
        }
        
        // Set up our MapView properties and delegate 
        mapView = MKMapView(frame: view.bounds)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.zoomEnabled = true
        
        addRemoveAnnotations(false)
        
        view.addSubview(mapView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - MKMapView Delegate
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        var region = MKCoordinateRegion()
        
        region.center = userLocation.coordinate
        region.span = MKCoordinateSpanMake(0.1, 0.1)
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: - CLLocationManager Delegate 
    // 参考地址：https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManager_Class/
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedAlways:
            manager.requestAlwaysAuthorization()
        case .AuthorizedWhenInUse:
            manager.requestLocation()
        case .NotDetermined:
            manager.requestWhenInUseAuthorization()
        case .Restricted, .Denied:
            let title = "Location Services Disable"
            let message = "Enable locations for this app via the Setting app on your iPhone."
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        if error?.code == CLError.DeferredFailed.rawValue { return }
        print("didFinsihDeferredUpdateWithError: \(error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else { return }
        updateSessionLocationDetails(mostRecentLocation)
        updateWatchTrackerLocation(mostRecentLocation)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        if error.code == CLError.LocationUnknown.rawValue { return }
        print("Failed to get a valid location: \(error)")
    }
    
    // MARK: - WCSession Delegate
    private func startWatchKitSession() {
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session?.delegate = self
            session?.activateSession()
        }
    }
    
    func updateSessionLocationDetails(location: CLLocation) {
        guard let session = session else { return }
        print("iPhone: Set application context: (applicationContext)")
        let data = NSKeyedArchiver.archivedDataWithRootObject(location)
        let context = ["lastFoundLocatoin": data]
        do {
            try session.updateApplicationContext(context)
        } catch {
            print("Update application context failed.")
        }
    }

    // MARK: - Private Methods
    func didLocationDistanceChange(updateLocation: CLLocation) -> Bool {
        guard let lastQueriedLocation = lastFoundLocation else {
            return false
        }
        
        let distance = lastQueriedLocation.distanceFromLocation(updateLocation)
        return distance > 400
    }
    
    func updateWatchTrackerLocation(location: CLLocation) {
        if didLocationDistanceChange(location) == false { return }
        
        print("iPhone: Current location has been changed.")
        self.lastFoundLocation = location
        
        let coordinate = location.coordinate
        
        addRemoveAnnotations(true, coordinate: coordinate)
        locationManager.allowDeferredLocationUpdatesUntilTraveled(400, timeout: 60)
    }
    
    func addRemoveAnnotations(isAdding: Bool, coordinate: CLLocationCoordinate2D? = nil) {
        if isAdding == false {
            let allAnnotations = self.mapView.annotations
            if allAnnotations.count > 0 {
                self.mapView.removeAnnotations(allAnnotations)
            }
        } else {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate!
            self.mapView.addAnnotation(annotation)
        }
    }
}

