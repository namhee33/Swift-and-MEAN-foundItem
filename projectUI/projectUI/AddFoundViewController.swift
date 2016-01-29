//
//  AddFoundViewController.swift
//  projectUI
//
//  Created by namhee kim on 1/28/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//

import UIKit

class AddFoundViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    
    weak var cancelButtonDelegate: FoundCancelButtonDelegate?
    
    weak var doneButtonDelegate: FoundDoneButtonDelegate?
    
    @IBOutlet weak var storeNameTextField: UITextField!
    
    
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBOutlet weak var detailTextView: UITextView!
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var newMedia: Bool?
    
    var iid = ""
    
    var myLocationX = 0.0
    
    var myLocationY = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailTextView.layer.borderWidth = 1
        detailTextView.layer.borderColor = UIColor.grayColor().CGColor
        print("iid in AddFound: ", iid)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func doneBtnPressed(sender: UIBarButtonItem) {
        
            self.postRequest()
        
    }
    
    
    @IBAction func cancelBtnPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.foundCancelButtonPressedFrom(self)
    }
    
    
    @IBAction func takeBtnPressed(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.Camera
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
                newMedia = true
        }

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])  {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage] as! UIImage, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }
    
    
    func postRequest()
    {
        
        let sName = storeNameTextField.text!
       
        let price_info = priceTextField.text!
        let details = detailTextView.text!
        
   
        let request = NSMutableURLRequest(URL: NSURL(string: hInfo + "addFound")!)
        
        request.HTTPMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let myPicture = imageView.image
        
        let myThumb1 = myPicture!.resize(0.1)
        
        let imageData = UIImageJPEGRepresentation(myThumb1, 0.6)

        
        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0)) // encode the image
        
        let err: NSError? = nil
        
        let params = ["image":[ "content_type": "image/jpeg", "filename":"img.jpg", "file_data": base64String], "storeName":sName, "price": price_info, "detail": details, "locationX": myLocationX, "locationY": myLocationY, "iid": iid]
        
        
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        }catch let error as NSError{
            print("jSon error: \(error.localizedDescription)")
        }
        
        
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                print("Image Response")
                self.doneButtonDelegate?.foundDoneButtonPressedFrom(self)
            
                }
            task.resume()
        
    }

    
}

extension UIImage {
    func resize(scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    func resizeToWidth(width:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}


