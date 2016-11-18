//
//  MapLocation.swift
//  NSManchester
//
//  Created by Ross Butler on 18/11/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class MapLocation: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
        super.init()
    }
    
    func pinTintColor() -> UIColor {
        return UIColor.red
    }
    
    func mapItem() -> MKMapItem? {
        
        var mapItem: MKMapItem? = nil
        
        if let subtitle = subtitle {
            let addressDictionary = [String(CNPostalAddressStreetKey): subtitle]
            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
            mapItem = MKMapItem(placemark: placemark)
            mapItem?.name = title
        }
        
        return mapItem

    }
    
}
