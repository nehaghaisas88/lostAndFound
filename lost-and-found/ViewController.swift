//
//  ViewController.swift
//  lost-and-found
//
//  Created by admin on 31/03/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import MapKit //to use MapKitView
import CoreLocation //to use Core location

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    //MKMapViewDelegate: used to only display the map contents
    //CLLocationManagerDelegate: to use Core library of location
    
    @IBOutlet weak var lattitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var altitiude: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var locationManagingVar = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManagingVar.delegate=self
        locationManagingVar.desiredAccuracy=kCLLocationAccuracyBest
        locationManagingVar.requestWhenInUseAuthorization() // to request usage when required
        locationManagingVar.startUpdatingLocation()
        
    }

    //locationManager function:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userlocation = locations[0]
        let userlatitude = userlocation.coordinate.latitude
        let userlongitude = userlocation.coordinate.longitude
        let latdelta : CLLocationDegrees = 0.05
        let longdelta :CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latdelta, longitudeDelta: longdelta)
        let location = CLLocationCoordinate2D(latitude: userlatitude, longitude: userlongitude)
        let region = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
        //print(locations) //to print the current location readings into the console
        //print(userlocation) //tp print extracted data from the array of locations
        //print(userlatitude)
        //print(userlongitude)
        
        //setting the labels with the required information in the labels:
        lattitude.text=String (userlatitude)
        longitude.text=String(userlongitude)
        altitiude.text=String(userlocation.altitude)
        speed.text=String(userlocation.speed)
        course.text=String(userlocation.course)
        
        CLGeocoder().reverseGeocodeLocation(userlocation){
            (placemarks, errors)in
            if errors != nil {
                print (errors)
            }
            else{
                //print(placemarks)
                if let placemark = placemarks?[0]{
                    var address=" "
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "
                    }
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + " "
                    }
                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + " "
                    }
                    if placemark.locality != nil {
                        address += placemark.locality! + " "
                    }
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + " "
                    }
                    if placemark.country != nil {
                        address += placemark.country! + " "
                    }
                    self.address.text=address
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

