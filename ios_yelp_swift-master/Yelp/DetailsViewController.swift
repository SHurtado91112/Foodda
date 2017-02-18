//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Steven Hurtado on 2/15/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailsViewController: UIViewController, CLLocationManagerDelegate
{

    var locationManager : CLLocationManager!
    
    //class variables
    @IBOutlet weak var mainDetailsView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    var nameLabelText = ""
    
    @IBOutlet weak var ratingImgView: UIImageView!
    var ratingImg = UIImage()
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    var reviewCountLabelText = ""
    
    @IBOutlet weak var categoriesLabel: UILabel!
    var categoriesText = ""
    
    @IBOutlet weak var numberLabel: UILabel!
    var numberText = ""
    
    //second view section variables
    
    @IBOutlet weak var secondDetailsView: UIView!
    @IBOutlet weak var localeImgView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    var addressLabelText = ""
    
    @IBOutlet weak var mapView: MKMapView!
    var lat = 0.0
    var long = 0.0
    
    @IBOutlet weak var backImgView: UIImageView!
    var backImgURL = URL(string: "")
    
    //third section
    @IBOutlet weak var tableView: UITableView!
    
    var span = MKCoordinateSpanMake(0.1, 0.1)
    var spanX = 0.1
    var spanY = 0.1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.title = "Details"
        
        print("Lat: \(lat) Long: \(long)")
        
        nameLabel.text = nameLabelText
        addressLabel.text = addressLabelText
        ratingImgView.image = ratingImg
        reviewCountLabel.text = reviewCountLabelText
        backImgView.setImageWith(backImgURL!)
        categoriesLabel.text = categoriesText
        numberLabel.text = numberText
        
        localeImgView.image = UIImage(named: "MapIt1x")?.withRenderingMode(.alwaysTemplate)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        
        mapView.tintColor = UIColor.myMatteGold
        
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        let destLocation = CLLocation(latitude: lat, longitude: long)
        
        addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D(latitude: lat , longitude: long))
        
        goToLocation(location: centerLocation, destLoc: destLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            span = MKCoordinateSpanMake(spanX, spanY)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
    }
    
    // add an Annotation with a coordinate: CLLocationCoordinate2D
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = nameLabelText
        
        mapView.addAnnotation(annotation)
    }

    func goToLocation(location: CLLocation, destLoc: CLLocation)
    {
        spanX = abs(location.coordinate.latitude-destLoc.coordinate.latitude) + 0.01
        spanY = abs(location.coordinate.longitude-destLoc.coordinate.longitude) + 0.01
        
        span = MKCoordinateSpanMake(spanX, spanY)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    override func didReceiveMemoryWarning()
    {
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
