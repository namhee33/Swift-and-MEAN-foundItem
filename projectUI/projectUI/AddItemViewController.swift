//
//  addItemViewController.swift
//  projectUI
//
//  Created by Sarah Sherman on 1/26/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//

import UIKit


class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GIDSignInDelegate, GIDSignInUIDelegate {
    
     weak var cancelButtonDelegate: CancelButtonDelegate?

     weak var doneButtonDelegate: DoneButtonDelegate?
    
    // saved by MainView
    var myLocationX = 0.0
    var myLocationY = 0.0
    var signedEmail = "test"
   
    @IBOutlet weak var signInNameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var googleSignView: GIDSignInButton!
    
    
    
    @IBOutlet weak var detailTextView: UITextView!
    
    
    @IBAction func selectBtnPressesd(sender: UIButton) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
   
    
    @IBAction func doneBtnPressed(sender: UIBarButtonItem) {

        
        postRequest()
     
        
    }
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // for Google SingIn
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self


        detailTextView.layer.borderWidth = 1
        detailTextView.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
//    func emailRequest(){
//        if let urlToReq = NSURL(string: hInfo+"emailMe"){
//            let request: NSMutableURLRequest = NSMutableURLRequest(URL: urlToReq)
//            request.HTTPMethod = "POST"
//            
//            let bodyData = "name=namhee"
//            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
//                (response, data, error) in
//                print("email done!")
//            }
//        }
//    }
    
    func postRequest()
    {
        
        
        let locate = locationTextField.text!
        let details = detailTextView.text!
        let iName = itemNameTextField.text!
        var uName = ""
        
         let request = NSMutableURLRequest(URL: NSURL(string: hInfo+"items")!)  //Dojo

        request.HTTPMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        

        
        let myPicture = imageView.image
        
        let myThumb1 = myPicture!.resize(0.1)
        
        let imageData = UIImageJPEGRepresentation(myThumb1, 0.6)
        
        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0)) // encode the image
        
        uName = signedEmail
        print("post:::: ", uName)
        
        let err: NSError? = nil
        
        let params = ["image":[ "content_type": "image/jpeg", "filename":"img.jpg", "file_data": base64String], "location":locate, "itemName": iName, "detail": details, "userName": uName, "locationX": myLocationX, "locationY": myLocationY]
        
        

        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        }catch let error as NSError{
            print("jSon error: \(error.localizedDescription)")
        }

        dispatch_async(dispatch_get_main_queue(), {
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                print("Image/Post has been successfully saved into the DB")
                self.doneButtonDelegate?.doneButtonPressedFrom(self)
                
            }
            task.resume()
        })
        
    }
    
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //        myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let name = user.profile.name
                signedEmail = user.profile.email!
                print("Email: ", signedEmail)

                self.navigationItem.title = name!
                googleSignView.hidden = true
                
            } else {
                print("\(error.localizedDescription)")
            }
    }


}

