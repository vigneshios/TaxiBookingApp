//
//  TaxiMapView.swift
//  TaxiBookingApp
//
//  Created by Vignesh on 01/04/19.
//  Copyright © 2019 Vignesh. All rights reserved.
//

import Foundation
import GoogleMaps

class TaxiMapView: GMSMapView, GMSMapViewDelegate {
    
    // Variables
    var cameraPosition: GMSCameraPosition?
    var mapIdleAt: ((CLLocationCoordinate2D) -> Void)?
    
    override func awakeFromNib() {
        self.delegate = self
    }
    
    func updateMapCamera(location: CLLocation) {
        cameraPosition = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 20.0)
        self.animate(to: cameraPosition!)
    }
    
    // Delegate - GMSMapViewDelegate Method
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.mapIdleAt?(position.target)
    }
    
    
}
