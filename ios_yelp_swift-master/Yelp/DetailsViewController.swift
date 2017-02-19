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

class DetailsViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource
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
    
    var reviewArr = [NSDictionary]()
    
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
    
    var selfLocation : CLLocation! = CLLocation()
    
    var span = MKCoordinateSpanMake(0.1, 0.1)
    var spanX = 0.1
    var spanY = 0.1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.mapView.layer.borderColor = UIColor.mySalmonRed.cgColor
        
        self.mapView.layer.borderWidth = 5
        self.mapView.layer.cornerRadius = 20
        
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
        
        self.selfLocation = locationManager.location
        
        let destLocation = CLLocation(latitude: lat, longitude: long)
        
        addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D(latitude: lat , longitude: long))
        
        goToLocation(destLocation: destLocation)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.tableView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            self.selfLocation = location
            
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

    func goToLocation(destLocation: CLLocation)
    {
        spanX = 3*abs(self.selfLocation.coordinate.latitude-destLocation.coordinate.latitude)
        spanY = 3*abs(self.selfLocation.coordinate.longitude-destLocation.coordinate.longitude)
        
        print(spanX - 0.01)
        print(spanY - 0.01)
        
        span = MKCoordinateSpanMake(spanX, spanY)
        
        let region = MKCoordinateRegionMake(self.selfLocation.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("Review Array Count: \(reviewArr.count)")
        
        return reviewArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.selectionStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        print("In Cell")
        
        let review = reviewArr[indexPath.row]
        
        let user = review["user"] as! NSDictionary
        cell.nameText = user["name"] as? String
        
        let avatarURL = user["image_url"] as! String
        
        cell.avatarImgView.setImageWith(URL(string: avatarURL)!)
        
        cell.excerptText = review["excerpt"] as? String
        
        cell.nameLabel.text = cell.nameText!
        cell.excerptLabel.text = cell.excerptText!
        
        print("Cell Excerpt and Name:\(cell.nameText) & \(cell.excerptText)")
        
        return cell
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
