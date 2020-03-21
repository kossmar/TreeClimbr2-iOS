//
//  LocationWorker.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright © 2020 Mar Koss. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationWorker: CLLocationManager, CLLocationManagerDelegate
{
    
    override init()
    {
        (super.init())
        self.delegate = self
        self.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            self.desiredAccuracy = kCLLocationAccuracyBest
            self.distanceFilter = 0.1
        }
        self.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        self.stopUpdatingLocation()
        NotificationCenter.default.post(name: Notification.Name.didUpdateLocation, object: self, userInfo: ["region": region])
    }
    
    func userRegion(location: MKUserLocation) -> MKCoordinateRegion
    {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        return region
    }
}
