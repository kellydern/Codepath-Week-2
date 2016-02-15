//
//  LoginViewController.swift
//  CarouselApp
//
//  Created by Kelly Dern on 2/7/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {
    
    //outlet for the text input field
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var buttonParentView: UIView!
    
    //define variables for the initial y and offset
    var initialY: CGFloat!
    var offset: CGFloat!
    
    //define variables for the initial position of the buttonParentView
    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!
    
    //login screen buttons
    @IBOutlet weak var signInScrollView: UIScrollView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signInScrollView.contentSize = signInScrollView.frame.size
        signInScrollView.contentInset.bottom = 100
        signInScrollView.delegate = self
        signInScrollView.contentSize = CGSize(width:320, height:1330)
        
        //showing and hiding the keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        //how much you are offsetting the keyboard
        initialY = fieldParentView.frame.origin.y
        offset = -50
        
        //button offset method
        buttonInitialY = buttonParentView.frame.origin.y
        buttonOffset = -120
        
        //within the keyboard will show method
        fieldParentView.frame.origin.y = initialY + offset
        
        //hide keyboard when tapping outside textfield
        fieldParentView.frame.origin.y = initialY
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //keyboard with show hide fields
    func keyboardWillShow(notification: NSNotification!) {
        fieldParentView.frame.origin.y = initialY + offset
        
        print("keyboardWillShow")
        // Move the button up above keyboard
        buttonParentView.frame.origin.y = buttonInitialY + buttonOffset
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        fieldParentView.frame.origin.y = initialY
        
        // Move the buttons back down to it's original position
        buttonParentView.frame.origin.y = buttonInitialY
    }
    
    //to get the back button to go back
    @IBAction func didPressBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didPressLogin(sender: AnyObject) {
        // Start animating the activity indicator
        loginIndicator.startAnimating()
        // Set the Button state to "Selected"
        loginButton.selected = true
        // If both the email and password fields match what we are looking for...
        if emailField.text == "hello@kellydern.com" && passwordField.text == "password" {
            // Delay for 2 second.
            delay(2, closure: { () -> () in
                // Stop animating the activity indicator.
                self.loginIndicator.stopAnimating()
                // Set the button state back to default, "Not Selected".
                self.loginButton.selected = false
                // perform the Segue to the next screen.
                self.performSegueWithIdentifier("yourSegue", sender: nil)
            })
            // Otherwise, email or password are incorrect so...
        } else {
            // Delay for 2 second
            delay(2, closure: { () -> () in
                // Stop animating the activity indicator.
                self.loginIndicator.stopAnimating()
                // Set the button state back to default, "Not Selected".
                self.loginButton.selected = false
                // Create and Show UIAlertController...see guide, Using UIAlertController
            })
        }
    }
    
    
    //hides Tap Gesture Recognizer
    @IBAction func didTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
    
    // create a cancel action
    let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
        // handle cancel response here. Doing nothing will dismiss the view.
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
