//
//  SecondViewController.swift
//  ProjectS3_CarFinder
//
//  Created by apple on 6/29/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let locations = DataManager.shareIntance.locations
        var annotations = [MKPointAnnotation]()
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotations.insert(annotation, at: annotations.count)
        }
        
        let oldAnnotations = mapView.annotations
        mapView.removeAnnotations(oldAnnotations)
        
        mapView.addAnnotations(annotations)
        
        if (annotations.count > 0) {
            let region = MKCoordinateRegionMake(annotations[0].coordinate, MKCoordinateSpanMake(0.1, 0.1))
            mapView.regionThatFits(region)
        }
        mapView.showsUserLocation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

