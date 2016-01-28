//
//  addItemViewController.swift
//  projectUI
//
//  Created by Sarah Sherman on 1/26/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
     weak var cancelButtonDelegate: CancelButtonDelegate?
<<<<<<< HEAD
    
    // saved by MainView
    var myLocationX = 3.24
    var myLocationY = 3.24
=======
     weak var doneButtonDelegate: DoneButtonDelegate?
    
    // saved by MainView
    var myLocationX = 0.0
    var myLocationY = 0.0
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    
    
    @IBOutlet weak var detailTextView: UITextView!
    
    
    @IBAction func selectBtnPressesd(sender: UIButton) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
   
    
    @IBAction func doneBtnPressed(sender: UIBarButtonItem) {
<<<<<<< HEAD
        postRequest()
=======
        
        postRequest()
        //email Test
        postEmail()
        
    }
    
    func postEmail(){
        if let urlToReq = NSURL(string: "http://namhees-MacBook-Pro.local:7000/emailMe"){
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            let info = "test"
           
            let bodyData = "name=\(info)"
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
                (response, data, error) in
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            }
        }
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
<<<<<<< HEAD
        imageView.layer.borderColor = UIColor.grayColor().CGColor
        imageView.backgroundColor = UIColor.blueColor()
=======
//        imageView.layer.borderColor = UIColor.grayColor().CGColor
//        imageView.backgroundColor = UIColor.blueColor()
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        detailTextView.layer.borderWidth = 1
        detailTextView.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func postRequest()
    {
        
        
        let locate = locationTextField.text!
        let details = detailTextView.text!
        let iName = itemNameTextField.text!
        let uName = "namhee"
        
        
        //        let request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.152:7000/items")!)
//        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:7000/items")!)
        
<<<<<<< HEAD
         let request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.152:7000/items")!)  //Dojo
=======
         let request = NSMutableURLRequest(URL: NSURL(string: "http://namhees-MacBook-Pro.local:7000/items")!)  //Dojo
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        request.HTTPMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.6)
        
        
        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0)) // encode the image
        
        
        
        let err: NSError? = nil
        
        let params = ["image":[ "content_type": "image/jpeg", "filename":"img.jpg", "file_data": base64String], "location":locate, "itemName": iName, "detail": details, "userName": uName, "locationX": myLocationX, "locationY": myLocationY]
        
        
<<<<<<< HEAD
        
=======
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        }catch let error as NSError{
            print("jSon error: \(error.localizedDescription)")
        }
<<<<<<< HEAD
        
        
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            print("Image/Post has been successfully saved into the DB")
            
        }
        task.resume()
=======

        dispatch_async(dispatch_get_main_queue(), {
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                print("Image/Post has been successfully saved into the DB")
                self.doneButtonDelegate?.doneButtonPressedFrom(self)
                
            }
            task.resume()
        })
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
        
    }

}
