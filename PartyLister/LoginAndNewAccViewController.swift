//  ***********************
//  LoginAndNewAccViewController.swift
//  PartyLister
//
//  Created by Regina Velasquez on 11/1/15.
//  Copyright © 2015 583. All rights reserved.
//  ***********************
//
//  Views animated movement to acomodate the keyboard taken from http://www.ioscreator.com/tutorials/move-view-behind-keyboard-ios8-swift
//

import UIKit
import Alamofire

class LoginAndNewAccViewController: UIViewController, UITextFieldDelegate {
    
    let loginBtnTitle = "Log in"
    let createNewAccTitle = "Create new account"
    let createAccTitle = "Create account"
    let cancelTitle = "Cancel"
    
    var keyboardHeight: CGFloat!
    var isKeyboardUp: Bool!
    
    // MARK: Textfields
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: Buttons
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newAccButton: UIButton!
    
    // MARK: Labels
    @IBOutlet weak var orLabel: UILabel!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        emailTextField.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        isKeyboardUp = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    @IBAction func login(sender: UIButton) {
        let username = userNameTextField.text!
        let password = passwordTextField.text!
        let email = emailTextField.text!
        let jsonStr: String!
        
        if (emailTextField.hidden) {
            jsonStr = createJSONWith(username, password: password, email: nil)
        } else {
            jsonStr = createJSONWith(username, password: password, email: email)
        }
        
        if (jsonStr != nil) {
            toogleControllersTo(false)
            print(jsonStr)
        }
        
        // TODO: Validate
        // TODO: Login get
    }
    
    @IBAction func createNewAccount(sender: UIButton) {
        let btnTitleLabel = sender.titleLabel!.text ?? ""

        if (btnTitleLabel.containsString(createNewAccTitle)) {
            emailTextField.hidden = false
            loginButton.setTitle(createAccTitle, forState: .Normal)
            sender.setTitle(cancelTitle, forState: .Normal)
        } else {
            emailTextField.hidden = true
            sender.setTitle(createNewAccTitle, forState: .Normal)
            loginButton.setTitle(loginBtnTitle, forState: .Normal)
        }
        // TODO: Create new acc post
    }
    
    // MARK: Methods
    
    /**
    Creates a JSON string
    
    - parameter username:
    - parameter password:
    - parameter email:
    
    - returns: JSON string
    */
    func createJSONWith(username: String, password: String, email: String!) -> String! {
        var strToReturn: String!
        
        if (!username.isEmpty && !password.isEmpty) {
            if (email == nil) {
                strToReturn = "{\"LOGIN\":{\"USERNAME\":\"" + username + "\", \"PASSWORD\":\"" + password + "\"}}"
            } else if (!email.isEmpty) {
                strToReturn = "{\"NEW_ACC\":{\"USERNAME\":\"" + username + "\", \"PASSWORD\":\"" + password + "\", \"EMAIL\":\"" + email + "\"}}"
            }
        }
        return strToReturn
    }
    
    func sendJSONToServer(jsonString: String) {
        print(jsonString)
    }

    func toogleControllersTo(boolean: Bool) {
        userNameTextField.enabled = boolean
        passwordTextField.enabled = boolean
        emailTextField.enabled = boolean
        loginButton.enabled = boolean
        newAccButton.enabled = boolean
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.height
                if isKeyboardUp == false {
                    self.animateViewsOffset(true)
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if isKeyboardUp == true {
            self.animateViewsOffset(false)
        }
    }
    
    func animateViewsOffset(up: Bool) {
        let offset = (up ? -keyboardHeight : keyboardHeight)
        isKeyboardUp = up
        
        // Animate
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, offset/2)
        })
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
