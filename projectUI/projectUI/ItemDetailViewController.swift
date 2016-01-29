//
//  ItemDetailViewController.swift
//  projectUI
//
//  Created by Sarah Sherman on 1/28/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//

import UIKit
import UberRides

class ItemDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FoundDoneButtonDelegate, FoundCancelButtonDelegate {
    
    var found = [NSDictionary]()
    var iid = ""
    var item: Item?
     var defaultImage = "noImageFound.png"
    var myLocationX = 0.0
    var myLocationY = 0.0
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var doneButtonDelegate: DoneButtonDelegate?

    
    var itemLocationX = 0.0
    var itemLocationY = 0.0
    
    @IBOutlet weak var uberButton: UIView!
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func addBtnPresssed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("foundSegue", sender: self)
    }
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    
    @IBOutlet weak var itemLabel: UILabel!
    
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var requestDateLabel: UILabel!
    
    
    @IBOutlet weak var replyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemLabel.text = item?.itemName
        detailsLabel.text = item?.detail
        requestDateLabel.text = item?.createdAt
        
        dispatch_async(dispatch_get_main_queue(), {
            self.itemImageView.image = self.loadImage(self.item!.imageUrl)
        })
        
        replyTableView.dataSource = self
        replyTableView.delegate = self
        print("viewLoading in detail view: ", iid)
        
        
        view.addSubview(uberButton)
        let button = RequestButton()
        uberButton.addSubview(button)
        
        
        
        button.setPickupLocation(latitude: String(myLocationX), longitude: String(myLocationY))
        button.setDropoffLocation(latitude: String(itemLocationX), longitude: String(itemLocationY))
        //button.setDropoffLocation(latitude: "47.00000", longitude: "-122.000000")
        
        centerButton(forButton: button, inView: uberButton)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        itemLocationX = found[indexPath.row]["locationX"] as! Double
        itemLocationY = found[indexPath.row]["locationY"] as! Double
        
    }
    
    func centerButton(forButton button: RequestButton, inView: UIView) {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        let horizontalConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: inView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: inView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
        // add constraints to view
        inView.addConstraints([horizontalConstraint, verticalConstraint])
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "foundSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddFoundViewController
            controller.cancelButtonDelegate = self
            controller.doneButtonDelegate = self
            controller.myLocationX = self.myLocationX
            controller.myLocationY = self.myLocationY
            controller.iid = self.iid
        }
    }
    
    func loadImage(imageUrl: String) -> UIImage{
        let imgUrl = hInfo + imageUrl
        print("image url in Found: ", imgUrl)
       
        let urlStr: NSString = imgUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let pictureURL = NSURL(string: urlStr as String)
        
        if let imageData = NSData(contentsOfURL: pictureURL!){
            return UIImage(data: imageData)!
        }
        return UIImage(named: defaultImage)!
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReplyCell")! as! ReplyCell
        let fDate = found[indexPath.row]["foundDate"] as! String
        cell.dateFoundLabel.text = changeDateToString(fDate)
        cell.priceLabel.text = String(found[indexPath.row]["price"]!)
        dispatch_async(dispatch_get_main_queue(), {
            cell.replyImageView.image = self.loadImage(String(self.found[indexPath.row]["imageUrl"]!))
            })
        
        cell.storeNameLabel.text = String(found[indexPath.row]["storeName"]!)
        
        return cell
    }
    
    func changeDateToString(fDate: String) -> String{
        print("original date: ", fDate)
        let df = NSDateFormatter()
        
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let createdAtShort = df.dateFromString(fDate)
        df.dateFormat = "EEE MMM d"
        let createdAt = df.stringFromDate(createdAtShort!)
        return createdAt
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return found.count
    }
        
    func foundCancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(false, completion: nil)
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
        
        
    }
    
    func foundDoneButtonPressedFrom(controller: UIViewController) {
        dispatch_async(dispatch_get_main_queue(), {
            self.doneButtonDelegate?.doneButtonPressedFrom(self)
        })
        dismissViewControllerAnimated(false, completion: nil)
        
        
        
    }

}
