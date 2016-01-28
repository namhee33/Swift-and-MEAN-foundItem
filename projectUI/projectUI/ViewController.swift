//
//  ViewController.swift
//  projectUI
//
//  Created by Sarah Sherman on 1/26/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//


// master file

import UIKit
import MapKit
import CoreLocation

<<<<<<< HEAD
class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, CancelButtonDelegate, MKMapViewDelegate, UISearchBarDelegate {
=======
class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, CancelButtonDelegate, DoneButtonDelegate, MKMapViewDelegate, UISearchBarDelegate {
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
    
    var locationManager: CLLocationManager!
    var location: CLLocation?
    
    
    var tableIsFoundItems = true
    var searchActive : Bool = false
    
<<<<<<< HEAD
    var items = [Item(name: "shoes", latitude: 47.611588, longitude: -122.196994, distance: 5, zipCode: 98004, details: "size 6", dateListed: "12/29/15", found: 0), Item(name: "shirt", latitude: 47.61067, longitude: -122.203068, distance: 5, zipCode: 98052, details: "blue, size small", dateListed: "1/14/16", found: 10), Item(name: "earrings", latitude: 49.000345, longitude: -122.197000, distance: 6, zipCode: 98008, details: "diamonds", dateListed: "1/20/16", found: 2)]
=======
    var items = [Item]()
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
    
    var tableItems = [Item]()
    
    var tempTable = [Item]()
    
<<<<<<< HEAD
=======
    var currentLocation: CLLocation?
    
    var defaultImage = "noImageFound.png"
    
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchOutlet: UISearchBar!
    
    @IBAction func foundButtonPressed(sender: UIButton) {
        print("heeeerrreee")
        if tableIsFoundItems == false {
            tableItems = []
            for var i = 0; i < items.count; ++i {
<<<<<<< HEAD
                if items[i].found != 0 {
=======
                if items[i].founds.count  != 0 {
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
                    tableItems.append(items[i])
                }
            }
            tableView.reloadData()
        }
        tableIsFoundItems = true
        
    }
    
    @IBAction func notFoundButtonPressed(sender: UIButton) {
        if tableIsFoundItems == true {
            tableItems = []
            for var i = 0; i < items.count; ++i {
<<<<<<< HEAD
                if items[i].found == 0 {
=======
                if items[i].founds.count  == 0 {
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
                    tableItems.append(items[i])
                }
            }
            tableView.reloadData()
        }
        tableIsFoundItems = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
=======
        dispatch_async(dispatch_get_main_queue(), {
            self.httpGetRequest()
        })
        
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        tableView.dataSource = self
        tableView.delegate = self
        map.delegate = self
        searchOutlet.delegate = self
        
<<<<<<< HEAD
        
        for var i = 0; i < items.count; ++i {
            if items[i].found != 0 {
                tableItems.append(items[i])
            }
        }
        
        tempTable = tableItems
=======
//        
//        for var i = 0; i < items.count; ++i {
//            if items[i].founds.count != 0 {
//                tableItems.append(items[i])
//            }
//        }
//        
//        tempTable = tableItems
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  //later change to kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
<<<<<<< HEAD
        let currentLocation = locationManager.location
=======
        currentLocation = locationManager.location
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        
        let location2D = CLLocationCoordinate2D(
            latitude: currentLocation!.coordinate.latitude,
            longitude: currentLocation!.coordinate.longitude
        )
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        
        let region = MKCoordinateRegion(center: location2D, span: span)
        
        map.setRegion(region, animated: true)
        let annotation = Pin(coordinate: location2D)
        annotation.title = "User"
        annotation.type = "User"
        map.addAnnotation(annotation)
        
        
        
        mapView(map, viewForAnnotation: annotation)
        
        
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Pin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                view.pinTintColor = annotation.pinColor()
                print(view.pinTintColor)
            }
            return view
        }
        return nil
    }
    
    // location stuffs
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[locations.count-1] as CLLocation
       
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
        
    }
  
<<<<<<< HEAD
    
    
=======
    func loadImage(imageUrl: String) -> UIImage{
        let imgUrl = "http://namhees-MacBook-Pro.local:7000/" + imageUrl
        print("ImageURL: ", imgUrl)
        let urlStr: NSString = imgUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let pictureURL = NSURL(string: urlStr as String)
        print("pictureURL: ", pictureURL!)
        if let imageData = NSData(contentsOfURL: pictureURL!){
            return UIImage(data: imageData)!
        }
        return UIImage(named: defaultImage)!
        
        
       /* let urlStr: NSString = imgUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        let urlStr: NSString = imgUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacter‌​Set())
        let urlStr : NSString = imgUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        print("Picture URL: ", urlStr)
        let pictureURL: NSURL = NSURL(string: urlStr as String)!
        let urlStr = "http://namhees-macbook-pro.local:7000/requestImages/test1.jpg" */
        
    }
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
    
    //table view stuffs
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell")! as! ItemCell
        let item = tableItems[indexPath.row]
<<<<<<< HEAD
        cell.zipCodeLabel.text = String(item.zipCode)
        cell.detailsLabel.text = String(item.details)
        cell.dateListedLabel.text = String(item.dateListed)
        cell.numberFoundLabel.text = String(item.found)
=======
        dispatch_async(dispatch_get_main_queue(), {
            cell.itemImage.image = self.loadImage(item.imageUrl)
        })
        cell.zipCodeLabel.text = item.location
        cell.detailsLabel.text = item.detail
        // ******* ?????? have to chaange date format
        cell.dateListedLabel.text = String(item.createdAt)
        cell.numberFoundLabel.text = String(item.founds.count)
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    //segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        let controller = navigationController.topViewController as! AddItemViewController
        controller.cancelButtonDelegate = self
<<<<<<< HEAD
=======
        controller.doneButtonDelegate = self
        controller.myLocationX = (currentLocation?.coordinate.longitude)!
        controller.myLocationY = (currentLocation?.coordinate.latitude)!
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        
    }

    
    // navigation functions
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
<<<<<<< HEAD
=======
    func doneButtonPressedFrom(controller: UIViewController){
        dispatch_async(dispatch_get_main_queue(), {
            self.httpGetRequest()
        })
//        tableItems = []
//        if tableIsFoundItems == false {
//            
//            for var i = 0; i < items.count; ++i {
//                if items[i].founds.count  == 0 {
//                    tableItems.append(items[i])
//                }
//            }
//            
//            tableIsFoundItems = false
//        }else{
//            for var i = 0; i < items.count; ++i {
//                if items[i].founds.count  != 0 {
//                    tableItems.append(items[i])
//                }
//            }
//            
//            tableIsFoundItems = true
//        }
//        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        removeAnnotations()
        addItemAnnotation(tableItems[indexPath.row])
        
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("hi")
    }
    
    func addItemAnnotation(item: Item){
        let itemAnnotation = MKPointAnnotation()
<<<<<<< HEAD
        let itemLocation2D = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
        itemAnnotation.coordinate = itemLocation2D
        itemAnnotation.title = item.name
=======
        let itemLocation2D = CLLocationCoordinate2D(latitude: item.locationY, longitude: item.locationX)
        itemAnnotation.coordinate = itemLocation2D
        itemAnnotation.title = item.itemName
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        self.map.addAnnotation(itemAnnotation)
        self.map.selectAnnotation(itemAnnotation,animated:true)
        
    }
    
    func removeAnnotations() {
        var annotationsToRemove = [MKAnnotation]()
        for var i = 0; i < map.annotations.count; ++i {
            if map.annotations[i].title! != "User" {
                annotationsToRemove.append(map.annotations[i])
            }
        }
        map.removeAnnotations(annotationsToRemove)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    //search functions
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print(tableItems)
        
        tempTable = tableItems
        print(tempTable)
        tableItems = []
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        print("hi")
        searchOutlet.text! = ""
        dismissKeyboard()
        tableItems = tempTable
        self.tableView.reloadData()
        searchActive = false;
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("here")
        tableItems = items.filter({ (Item) -> Bool in
<<<<<<< HEAD
            let tmp: NSString = NSString(string: Item.name)
=======
            let tmp: NSString = NSString(string: Item.itemName)
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        
        if(tableItems.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
<<<<<<< HEAD
=======
    
    func httpGetRequest(){
        items = []
        //        if let urlToReq = NSURL(string: "http://localhost:7000/items"){
//        if let urlToReq = NSURL(string: "http://192.168.1.152:7000/items"){  //Dojo
        if let urlToReq = NSURL(string: "http://namhees-MacBook-Pro.local:7000/items"){  //Home
            
            if let packagedData = NSData(contentsOfURL: urlToReq){
                if let unpackagedData = parseJSON(packagedData){
                    //                    print("@@@ data from server: ", unpackagedData)
                    for newItem in unpackagedData {
//                        let item = data as! Item
                        let iid = newItem["_id"] as! String
                        let userName = newItem["userName"] as! String
                        let location = newItem["location"] as! String
                        let itemName = newItem["itemName"] as! String
                        let detail = newItem["detail"] as! String
                        let locationX = newItem["locationX"] as! Double
                        let locationY = newItem["locationY"] as! Double
                        let imageUrl = newItem["imageUrl"] as! String
                        let createdDate = newItem["createdAt"] as! String
                        //change Date
                        let df = NSDateFormatter()
                        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        print("createdDate: ", createdDate)
                        
                        let createdAtShort = df.dateFromString(createdDate)
                        df.dateFormat = "EEE MMM d"
                        let createdAt = df.stringFromDate(createdAtShort!)
                        
                        let item = Item(iid: iid, userName: userName, itemName: itemName, locationX: locationX, locationY: locationY, details: detail, dateListed: createdAt, imageUrl: imageUrl, location: location)
                        
                        self.items.append(item)
                        
                        print("\(iid), \(itemName), \(imageUrl)")
                        
                        if newItem["founds"] != nil {
                            let newFounds = newItem["founds"] as! NSArray
                            if newFounds.count != 0 {
                                
                                for fItem in newFounds {
                                    item.founds.append(fItem as! NSDictionary)
                                }
                            }
                        }
                    }
                    updateTable()
                }else{
                    print("Error unpackaging data")
                }
            }else{
                print("Error requesting data")
            }
        }else{
            print("Error creating NSURL")
        }
    }
    
    func updateTable(){
        tableItems = []
        if tableIsFoundItems == false {

            for var i = 0; i < items.count; ++i {
                if items[i].founds.count  == 0 {
                    tableItems.append(items[i])
                }
            }

            tableIsFoundItems = false
        }else{
            for var i = 0; i < items.count; ++i {
                if items[i].founds.count  != 0 {
                    tableItems.append(items[i])
                }
            }
            
            tableIsFoundItems = true
        }
        tableView.reloadData()

    }
    
    func parseJSON(inputData: NSData) -> NSArray? {
        var error: NSError?
        var arrOfObjects: NSArray?
        
        do {
            arrOfObjects = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as? NSArray
        } catch let error as NSError {
            print("jSon error: \(error.localizedDescription)")
        }
        return arrOfObjects!
    }

>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792


}

