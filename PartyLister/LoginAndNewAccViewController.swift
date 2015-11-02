//
//  LoginAndNewAccViewController.swift
//  PartyLister
//
//  Created by Regina Velasquez on 11/1/15.
//  Copyright © 2015 583. All rights reserved.
//

import UIKit

class LoginAndNewAccViewController: UIViewController {

    // MARK: Textfields
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: Buttons
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newAccButton: UIButton!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func login(sender: UIButton) {
        // TODO: Call the build JSON object method
        // TODO: Call the send to server method
    }
    
    @IBAction func createNewAccount(sender: UIButton) {
        // TODO: Animate e-mail textfield
        // TODO: Change the login button text to create acc
    }
    
    // MARK: Methods
    func createJSONWith(username: String, password: String, email: String){
        // TODO: Build Json object
    }
    
    func sendJSONToServer(obj: JSON){
        // TODO: Send to server
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
