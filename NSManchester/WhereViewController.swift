//
//  GettingHereViewController.swift
//  NSManchester
//
//  Created by Ross Butler on 29/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit
import MapKit

class WhereViewController: UIViewController {
    
    // Outlets
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var locationManager = CLLocationManager()

    // MARK: View lifecycle

    override func viewDidLoad() {

        // Centre the map on venue
        let initialLocation = CLLocation(latitude: 53.484277, longitude: -2.236451)
        centerMapOnLocation(initialLocation)
        
        let location = MapLocation(title: "Madlab",
                                   subtitle:"36 - 40 Edge Street, Manchester",
                                   coordinate: initialLocation.coordinate)
        mapView.addAnnotation(location)
        mapView.selectAnnotation(location, animated: true)
        
        mapView.showsUserLocation = true
        mapView.showsBuildings = true
        mapView.delegate = self
        checkLocationAuthorizationStatus()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reload(_:)),
                                               name: NSNotification.Name.FeedDataUpdated,
                                               object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    let regionRadius: CLLocationDistance = 100
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // Notifications
    
    @objc func reload(_ notification: Notification) {
        DispatchQueue.main.async { [unowned self] in
            self.mapView.reloadInputViews()
        }
    }
}
