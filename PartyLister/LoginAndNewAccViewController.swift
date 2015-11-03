//
//  LoginAndNewAccViewController.swift
//  PartyLister
//
//  Created by Regina Velasquez on 11/1/15.
//  Copyright © 2015 583. All rights reserved.
//

import UIKit

class LoginAndNewAccViewController: UIViewController, UITextFieldDelegate {
    
    var keyboardHeight: CGFloat!
    
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func login(sender: UIButton) {
        // TODO: Validate
    }
    
    @IBAction func createNewAccount(sender: UIButton) {
        emailTextField.hidden = false
        emailTextField.enabled = true
        
        loginButton.titleLabel?.text = "Create"

        orLabel.hidden = true
        newAccButton.hidden = true
    }
    
    // MARK: Methods
    func createJSONWith(username: String, password: String, email: String) {
        // TODO: Build Json object
    }
    
    func sendJSONToServer(obj: JSON) {
        // TODO: Send to server
    }

    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.height
                self.animateViewsOffset(true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateViewsOffset(false)
    }
    
    func animateViewsOffset(up: Bool) {
        let offset = (up ? -keyboardHeight : keyboardHeight)
        
        // Animate
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, offset)
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
