//
//  WhereMapViewDelegate.swift
//  NSManchester
//
//  Created by Ross Butler on 30/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import MapKit

extension WhereViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? MapLocation {
            
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            
            view.pinTintColor = annotation.pinTintColor()
            
            return view
            
        }
        
        return nil
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        activityIndicatorView.stopAnimating()
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        
        activityIndicatorView.stopAnimating()
        
        let alertController = UIAlertController(title: "Unable to download map data",
                                                message: "Please check that you are connected to the Internet and try again.",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true) {}
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let location = view.annotation as? MapLocation {
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem()?.openInMaps(launchOptions: launchOptions)
        }
        
    }
}
