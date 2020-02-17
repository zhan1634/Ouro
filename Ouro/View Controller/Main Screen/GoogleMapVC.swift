//
//  GoogleMapVC.swift
//  Ouro
//
//  Created by PC on 23/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Firebase

class GoogleMapVC: BaseViewController,CLLocationManagerDelegate,UISearchBarDelegate,UIGestureRecognizerDelegate{
    
    //MARK:- Outlets
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnlocation: UIButton!
    @IBOutlet weak var btngenerate: UIButton!
    
    
    //MARK:- Location Variables
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView = GMSMapView()
    var zoomLevel: Float = 15.0
    
    //MARK:- Scroll Variables
    var currentScroll = CGFloat()
    var verticalShift = CGFloat()
    var scrollState = Bool()
   
    // Search Variable
    lazy var geocoder = CLGeocoder()
    var searchString: String = ""
    var searchLat = Double()
    var searchLong = Double()
    var setLocationPreferences = CLLocation()
    var isFromGenerated : Bool = false
    var users = [String]()
    var geoFire = GeoFire(firebaseRef: Database.database().reference().child("Locations"))

    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyALizHyvUmnpjNuiwqRfyUStlP9ZLbcxn4")
        let camera = GMSCameraPosition.camera(withLatitude: 43.6532, longitude: 79.3832, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), camera: camera)
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.consumesGesturesInView = true
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }else {
                print("Unable to find style.json")
            }
        }
        catch {
            print("The style definition could not be loaded: \(error)")
        }
        self.view.addSubview(mapView)// = mapView
        self.view.bringSubviewToFront(btnBack)
        self.view.bringSubviewToFront(btnSetting)
        self.view.bringSubviewToFront(searchBar)
        self.view.bringSubviewToFront(btngenerate)
        self.view.bringSubviewToFront(btnlocation)
        // Location Properties
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
 
        searchBar.delegate = self
        searchBar.compatibleSearchTextField.textColor = UIColor.gray
        searchBar.compatibleSearchTextField.backgroundColor = UIColor.white
    }
    
    //MARK:  Set Loaction Authorization Status change
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
        @unknown default:
            fatalError()
        }
    }
    
    //MARK:  Set the updated location
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
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    //
    
    @IBAction func btnBack(_ sender: Any) {
//        self.navigationController?.isNavigationBarHidden = false
//        let chooseExperianceNav = ChooseExperianceVC.instantiate(fromAppStoryboard: .Main)
//        self.addChild(chooseExperianceNav)
//        chooseExperianceNav.view.frame = self.view.frame
////        self.view.addSubview(chooseExperianceNav.view)
//        chooseExperianceNav.didMove(toParent: self)
        dismiss(animated: true, completion: {
            let ChooseExeperianceNav = ChooseExperianceVC.instantiate(fromAppStoryboard: .Main)
            let navigationController = UINavigationController(rootViewController: ChooseExeperianceNav)
            navigationController.navigationBar.isHidden = true
            navigationController.modalPresentationStyle = .fullScreen
//                            self.navigationController?.pushViewController(navigationController, animated: true)
            self.present(navigationController, animated: true, completion: nil)
        })
    }
    
    @IBAction func btnGenerate(_ sender: Any) {
//        DispatchQueue.main.async {
//            let center = self.setLocationPreferences
//            var radius = UserDefaults.standard.double(forKey: "SearchDistance")
//            if radius <= 0 {
//                radius = 5
//            }//38 Dan Leckie Way Toronto
//            let circleQuery = self.geoFire.query(at: center, withRadius: radius)
//            let queryHandle = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
//                self.users.append(key)
//                print("Users :",self.users)
//            })
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.users.count == 0 {
                // https://www.swiftdevcenter.com/change-font-text-color-and-background-color-of-uialertcontroller/
                
                let alertController = UIAlertController(title: "", message: "No Results Found - Please update your selection and try again", preferredStyle: .alert)
                
                // Change font and color of title
                alertController.setTitlet(font: UIFont.boldSystemFont(ofSize: 26), color: UIColor.white)
                
                // Change font and color of message
                alertController.setMessage(font: UIFont.boldSystemFont(ofSize: 15), color: UIColor.white)
                
                // Change background color of UIAlertController
                alertController.setBackgroundColor(color: UIColor.black)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                alertController.setTint(color: .white)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.isFromGenerated = true
                let generateexpNav = GenerateExperianceVC.instantiate(fromAppStoryboard: .Main)
                print(self.setLocationPreferences)
                generateexpNav.setLocation = self.setLocationPreferences
                self.addChild(generateexpNav)
                generateexpNav.view.frame = self.view.frame
                self.view.addSubview(generateexpNav.view)
                generateexpNav.didMove(toParent: self)
            }
        }
    }
    
    @IBAction func btnLocationClick(_ sender: UIButton)  {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    @IBAction func btnpreferences(_ sender: Any) {
        let Preferencesnav = PreferencesVC.instantiate(fromAppStoryboard: .Main)
        let navigationController = UINavigationController(rootViewController: Preferencesnav)
        navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func btnSetting(_ sender: Any) {
    }
    
    // Mark: Search Bar Protocol Activities
    func searchBar(_ SearchBar: UISearchBar, textDidChange textSearched: String) {
        searchString = textSearched
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Geocode Address String
        geocoder.geocodeAddressString(searchString) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    //MARK: Set the Location after the search
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
                
                let center = self.setLocationPreferences
                var radius = UserDefaults.standard.double(forKey: "SearchDistance")
                if radius <= 0 {
                    radius = 5
                }//38 Dan Leckie Way Toronto
                let circleQuery = self.geoFire.query(at: center, withRadius: radius)
                let queryHandle = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
                    self.users.append(key)
                    print("Users :",self.users)
                })
            } else {
            }
        }
    }
}

extension UISearchBar {
    var dtXcode: Int {
        if let dtXcodeString = Bundle.main.infoDictionary?["DTXcode"] as? String {
            if let dtXcodeInteger = Int(dtXcodeString) {
                return dtXcodeInteger
            }
        }
        return Int()
    }
    // Due to searchTextField property who available iOS 13 only, extend this property for iOS 13 previous version compatibility
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *), dtXcode >= 1100 else { return legacySearchField }
        return self.searchTextField
    }
    var legacySearchField: UITextField {
        guard let textField = self.subviews.first?.subviews.last as? UITextField else { return UITextField() }
        return textField
    }
}
