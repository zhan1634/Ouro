//
//  ParametersViewController.swift
//  Ouro
//
//  Created by Jack Zhang on 2019-04-28.
//  Copyright © 2019 Ouro. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ParametersViewController: UIViewController, UIGestureRecognizerDelegate, CLLocationManagerDelegate, UISearchBarDelegate {

    // Location Variables
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0
    
    // Scroll Variables
    var currentScroll = CGFloat()
    var verticalShift = CGFloat()
    var scrollState = Bool()
    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "preferencesViewID") as! PreferencesViewController
    
    // Button Variable
    @IBOutlet weak var GenerateButton: UIButton!
    
    // Search Variable
    lazy var geocoder = CLGeocoder()
    @IBOutlet weak var SearchBar: UISearchBar!
    var searchString: String = ""
    var searchLat = Double()
    var searchLong = Double()
    var setLocationPreferences = CLLocation()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Google Maps
        GMSServices.provideAPIKey("AIzaSyALizHyvUmnpjNuiwqRfyUStlP9ZLbcxn4")
        let camera = GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), camera: camera)
        mapView.settings.scrollGestures = false
        mapView.settings.zoomGestures = false
        mapView.settings.consumesGesturesInView = false
        self.view = mapView

//        locationManager.distanceFilter = 50
        
        // Generate Button Properties
        GenerateButton.isHidden = false
        self.view.addSubview(GenerateButton)
        
        // Generate Button Properties
        SearchBar.delegate = self
        SearchBar.isHidden = false
        self.view.addSubview(SearchBar)
        
        // Drag initialization for preferences
        let drag = UIPanGestureRecognizer(target: self, action: #selector(ParametersViewController.touch(sender:)))
        view.addGestureRecognizer(drag)
        popOverVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY * (7/8), width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popOverVC.view)
        scrollState = false

        // Location Properties
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    
    // MARK: Button Pressed
    
    @IBAction func Generate(_ sender: Any) {
        
        let popGenerateVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GenerateScreen") as! GenerateViewController
        popGenerateVC.setLocation = self.setLocationPreferences
        self.addChild(popGenerateVC)
        popGenerateVC.view.frame = self.view.frame
        self.view.addSubview(popGenerateVC.view)
        popGenerateVC.didMove(toParent: self)
        
    }

    // MARK: Scroll Screen Recognizer
    
    @objc func touch(sender: UIPanGestureRecognizer) {

        let translation = sender.translation(in: self.view)
        
        if sender.state == UIGestureRecognizer.State.began {
        
            currentScroll = popOverVC.view.frame.minY
            if scrollState == true && translation.y > 0 {
                popOverVC.removeFromParent()
                popOverVC.UpDownLabel = "Up"
            }
            
        } else if sender.state == UIGestureRecognizer.State.changed {
            
            verticalShift = currentScroll + translation.y
            
            if verticalShift > (self.view.frame.maxY * (7/8)) {
                verticalShift = self.view.frame.maxY * (7/8)
            } else if verticalShift <= (self.view.frame.minY) {
                verticalShift = self.view.frame.minY
            }

            self.popOverVC.view.frame = CGRect(x: 0, y: verticalShift, width: self.view.frame.width, height: self.view.frame.height)

        } else if sender.state == UIGestureRecognizer.State.ended {

            if scrollState == false && translation.y < 0 {
                UIView.animate(withDuration: 0.1) {
                    self.popOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                }
                scrollState = true
                popOverVC.UpDownLabel = "Down"
                self.addChild(popOverVC)
                
            } else if scrollState == true && translation.y > 0 {
                UIView.animate(withDuration: 0.1) {
                    self.popOverVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY * (5/6), width: self.view.frame.width, height: self.view.frame.height)
                }
                scrollState = false
            }
        }

    }
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        self.mapView.animate(to: camera)
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            setLocationPreferences = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    // Mark: Search Bar Protocol Activities
    func searchBar(_ SearchBar: UISearchBar, textDidChange textSearched: String) {
        searchString = textSearched
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.SearchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Geocode Address String
        geocoder.geocodeAddressString(searchString) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                searchLat = coordinate.latitude
                searchLong = coordinate.longitude
                
                setLocationPreferences = CLLocation(latitude: searchLat, longitude: searchLong)
                
                let camera = GMSCameraPosition.camera(withLatitude: searchLat,
                                                      longitude: searchLong,
                                                      zoom: zoomLevel)
                self.mapView.animate(to: camera)
            } else {
            }
        }
    }
    
}
