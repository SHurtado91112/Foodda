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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.title = "Details"
        
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
        
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location: centerLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
    }

    func goToLocation(location: CLLocation)
    {
        let span = MKCoordinateSpanMake(0.1, 0.1)
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
