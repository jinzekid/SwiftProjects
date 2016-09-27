//
//  ViewController.swift
//  Project3-Map
//
//  Created by YangLu on 16/6/5.
//  Copyright © 2016年 YangLu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate {

    // MARK: - IBOutles
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Utiliy Methods
    //
    func initSearchbarPro() {
        self.searchBar.delegate = self
    }
    
    // MARK: - Searchbar delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
    }


}

