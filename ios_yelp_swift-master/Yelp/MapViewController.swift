//
//  MapViewController.swift
//  Yelp
//
//  Created by Steven Hurtado on 2/18/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate
{
    var locationManager : CLLocationManager!
    var selfLocation : CLLocation! = CLLocation()
    
    @IBOutlet weak var mapView: MKMapView!
    
    var arrayLocations : [(CLLocation, String)]!
    
    var spanX : Double!
    var spanY : Double!

    var maxX : Double! = 0.001
    var maxY : Double! = 0.001
    
    var span = MKCoordinateSpan()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.mapView.layer.borderColor = UIColor.mySalmonRed.cgColor
        
        self.mapView.layer.borderWidth = 5
        self.mapView.layer.cornerRadius = 20
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        
        mapView.tintColor = UIColor.myMatteGold
        
        self.selfLocation = locationManager.location
        
        var farthestLocation : CLLocation!
        
        print("Count: \(arrayLocations.count)")
        
        for i in 0...(arrayLocations.count-1)
        {
            let lat = arrayLocations[i].0.coordinate.latitude
            
            let long = arrayLocations[i].0.coordinate.longitude
            
            let nameText = arrayLocations[i].1
            
            let destCoord = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let destLocation = CLLocation(latitude: lat, longitude: long)
            
            addAnnotationAtCoordinate(coordinate: destCoord, nameLabelText: nameText)
         
            goToLocation(destLocation: destLocation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            self.selfLocation = location
            
            print("self location : \(self.selfLocation)")
            
            span = MKCoordinateSpanMake(maxX, maxY)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
    }
    
    // add an Annotation with a coordinate: CLLocationCoordinate2D
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D, nameLabelText: String)
    {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = nameLabelText
        
        mapView.addAnnotation(annotation)
    }
    
    func goToLocation(destLocation: CLLocation)
    {
        spanX = 3*abs(self.selfLocation.coordinate.latitude-destLocation.coordinate.latitude)
        spanY = 3*abs(self.selfLocation.coordinate.longitude-destLocation.coordinate.longitude)
        
        if(spanX > maxX)
        {
            maxX = spanX
        }
        
        if(spanY > maxY)
        {
            maxY = spanY
        }
        
        print("MAX X: \(maxX) CURR: \(spanX) ")
        print("MAX Y: \(maxY) CURR: \(spanY) ")
        
        span = MKCoordinateSpanMake(maxX, maxY)//spanX, spanY)
        
        let region = MKCoordinateRegionMake(self.selfLocation.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
