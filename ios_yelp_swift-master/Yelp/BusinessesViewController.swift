//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import CoreLocation

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    
    var businesses: [Business]!
    var reviews: [NSDictionary]!
    
    var searchTerm = "Restaurants"
    let searchBar = UISearchBar()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dotLoader: DotsLoader!
    var loading : Bool = false
    
    var arrayLocation : [(CLLocation, String)]! = [(CLLocation, String)]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let dismissGes = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        dismissGes.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(dismissGes)
        
        self.searchBar.placeholder = "Restaurants"
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        self.tableView.alpha = 0
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.myMatteGold
        
        Business.searchWithTerm(term: searchTerm, completion:
            { (businesses: [Business]?, error: Error?) -> Void in
            
                self.businesses = businesses
                
                self.tableView.reloadData()
                
                if let businesses = businesses
                {
                    for business in businesses
                    {
                        print(business.name!)
                        print(business.address!)
                    }
                }
            
            }
        )
        
        // create the search bar programatically since you won't be
        // able to drag one onto the navigation bar
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        // the UIViewController comes with a navigationItem property
        // this will automatically be initialized for you if when the
        // view controller is added to a navigation controller's stack
        // you just need to set the titleView to be the search bar
        navigationItem.titleView = searchBar
       
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        self.tableView.insertSubview(refreshControl, at: 0)
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        searchTerm = searchText.isEmpty ? "Restaurants" : searchText
        
        Business.searchWithTerm(term: searchTerm, completion:
            { (businesses: [Business]?, error: Error?) -> Void in
                
                self.businesses = businesses
                
                self.arrayLocation =  [(CLLocation, String)]()

                self.tableView.reloadData()
                
                if let businesses = businesses
                {
                    for business in businesses
                    {
                        print(business.name!)
                        print(business.address!)
                    }
                }
                
        }
        )

        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        fetchNewDataFromServer()
    }

    // data fetcher function
    func fetchNewDataFromServer() {
        if(!loading)
        {
            self.dotLoader.alpha = 1
            
            
            UIView.animate(withDuration: 0.3, animations: {
                self.dotLoader.alpha = 0
                self.tableView.alpha = 1
            }, completion: { _ in
                self.dotLoader?.removeFromSuperview()
                self.loading = true
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(businesses != nil)
        {
            return businesses.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        arrayLocation.append((CLLocation(latitude: cell.business.coordinate.0, longitude: cell.business.coordinate.1), cell.business.name!))
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.selectionStyle = .none
        
        self.performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    
    func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        self.searchBar.resignFirstResponder()
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl)
    {
        
        Business.searchWithTerm(term: searchTerm, completion:
            { (businesses: [Business]?, error: Error?) -> Void in
                
                self.businesses = businesses
                
                self.tableView.reloadData()
                
                if let businesses = businesses
                {
                    for business in businesses
                    {
                        print(business.name!)
                        print(business.address!)
                    }
                }
                
        }
        )
        
        
        self.tableView.reloadData()
        
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func mapAllBtnPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "mapSegue", sender: self)
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
     {
        print("Comes")
        print(segue.identifier!)
        
        if(segue.identifier! == "detailSegue")
        {
            print("conditional met")
            let vc = segue.destination as! DetailsViewController
            
            let cell = tableView.cellForRow(at: sender as! IndexPath) as! BusinessCell
            
            vc.nameLabelText = cell.nameLabel.text!
            vc.addressLabelText = cell.addressLabel.text!
            vc.reviewCountLabelText = cell.reviewCountLabel.text!
            vc.ratingImg = cell.ratingImageView.image!
            vc.backImgURL = cell.business.imageURL!
            vc.categoriesText = cell.categoryLabel.text!
            vc.numberText = cell.phoneNumber!
            
            vc.lat = cell.coordinate.0
            vc.long = cell.coordinate.1
            
            
            ////Reviews
            Business.businessWithId(id: cell.id, completion: { (review: [NSDictionary]?, error: Error?) -> Void in
                
                self.reviews = review
                
                if review != nil
                {
                   vc.reviewArr = self.reviews
                    print("Business Reviews : \(self.reviews)")
                }
                
            })
        }
        
        if(segue.identifier! == "mapSegue")
        {
            let vc = segue.destination as! MapViewController
            vc.arrayLocations = self.arrayLocation
        }
     }

    
}
