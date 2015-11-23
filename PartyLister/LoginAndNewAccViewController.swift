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

class LoginAndNewAccViewController: UIViewController, UITextFieldDelegate {
    
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
        
        emailTextField.enabled = false
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
        
        let jsonStr = createJSONWith(username, password: password, email: nil)
        
        if (jsonStr != nil) {
           sendJSONToServer(jsonStr)
        } else {
            // TODO: pop up warning
            print("empty fields")
        }
        
        // TODO: Validate
        // TODO: Login get
        // TODO: Create new acc post
    }
    
    @IBAction func createNewAccount(sender: UIButton) {
        let str = sender.titleLabel!.text!
        
        switch str {
        case "Create new account":
            emailTextField.hidden = false
            emailTextField.enabled = true
            loginButton.titleLabel?.text = "Create"
            newAccButton.titleLabel?.text = "Cancel"
        case "Cancel":
            emailTextField.hidden = true
            emailTextField.enabled = false
            loginButton.titleLabel?.text = "Login"
            newAccButton.titleLabel?.text = "Create new account"
        default: break
        }
        
        
    }
    
    // MARK: Methods
    func createJSONWith(username: String, password: String, email: String!) -> String! {
        var strToReturn: String!
        
        if (!username.isEmpty && !password.isEmpty) {
            strToReturn = "{user: {username: \"" + username + "\", password:\"" + password + "\"}}"
        }
        return strToReturn
    }
    
    func sendJSONToServer(jsonString: String) {
        // TODO: Send to server
        
        print(jsonString)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
