//
//  TaxiHomeVC.swift
//  TaxiBookingApp
//
//  Created by Vignesh on 01/04/19.
//  Copyright © 2019 Vignesh. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class TaxiHomeVC: UIViewController, CLLocationManagerDelegate {

    // Outlets
    @IBOutlet weak var taxiMapVw: TaxiMapView!
    @IBOutlet weak var carsList: CarsList!
    @IBOutlet weak var pickUpLocationLbl: UILabel!
    @IBOutlet weak var destinationBox: UIView!
    
    
    
    // Variables
    var locationManager = CLLocationManager()
    var geoCoder = GMSGeocoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setUpMapVW()
    }
    
    func setUpMapVW() {
        taxiMapVw.mapIdleAt = {
            (location) in
            self.getAddressFromCoordinates(location: location)
        }
    }
    
    // Get address from coordinates by passing locationcoordinate2D
    func getAddressFromCoordinates(location: CLLocationCoordinate2D) {
        geoCoder.reverseGeocodeCoordinate(location) { (res, err) in
            if let res = res?.firstResult() {
                self.pickUpLocationLbl.text = res.lines?.joined(separator: " ")
            }
        }
    }
    
    
    // Delegate Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0]
        taxiMapVw.updateMapCamera(location: currentLocation)
        getAddressFromCoordinates(location: currentLocation.coordinate)
    }
    
   
    
    

}
