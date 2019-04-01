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
    @IBOutlet weak var destinationLbl: UILabel!
    
    
    
    // Variables
    var locationManager = CLLocationManager()
    var geoCoder = GMSGeocoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UIGestureRecognizer(target: self, action: #selector(TaxiHomeVC.destinationTapped))
        destinationBox.addGestureRecognizer(tap)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setUpMapVW()
    }
    
    @objc func destinationTapped() {
        let autoCompleteVC = GMSAutocompleteViewController()
        autoCompleteVC.delegate = self
        self.present(autoCompleteVC, animated: true, completion: nil)
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


extension TaxiHomeVC: GMSAutocompleteViewControllerDelegate {
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        destinationLbl.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error = \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
