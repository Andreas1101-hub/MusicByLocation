//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Andreas Kwong on 19/03/2024.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocation: String = ""
    @Published var lastKnownCountry: String = ""
    @Published var lastKnownPostCode: String = ""
    @Published var lastKnownAddress: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.lastKnownLocation = "Could not perform lookup of location from coordinate information"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        self.lastKnownLocation = firstPlacemark.locality ?? "Couldn't find locality"
                        self.lastKnownCountry = firstPlacemark.country ?? "Couldn't find country"
                        self.lastKnownPostCode = firstPlacemark.postalCode ?? "Couldn't find postalcode"
                        self.lastKnownAddress = firstPlacemark.name ?? "Couldn't find address"
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocation = "Error finding location"
    }
}
