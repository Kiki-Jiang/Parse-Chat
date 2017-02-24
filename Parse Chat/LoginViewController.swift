//
//  ViewController.swift
//  Parse Chat
//
//  Created by 蒋逍琦 on 2/23/17.
//  Copyright © 2017 蒋逍琦. All rights reserved./Users/jiangxiaoqi/Desktop/cp/Parse Chat/Parse Chat/ViewController.swift
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
        user.username = emailField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        user.signUpInBackground {
            (success: Bool, error: Error?) -> Void in
            if let error = error {
                let errorString = (error as NSError).userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                print(errorString ?? 0)
                
                //alert
                let alertController = UIAlertController(title: "Sign Up Failed", message: errorString as String?, preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion:nil)
                
                
            } else {
                // Hooray! Let them use the app now.
                print("signup")
                
                self.performSegue(withIdentifier: "firstSegue", sender: nil)
            }
        }
    }

    @IBAction func login(_ sender: Any) {
        let userEmail = emailField.text
        let userPassword = passwordField.text
        
        //Check that both fields are filled
        if !(userEmail?.isEmpty)! && !(userPassword?.isEmpty)! {
            PFUser.logInWithUsername(inBackground: userEmail!, password: userPassword!) { (user, error) -> Void in
                if error == nil {
                    print("succesful")
                    
                    self.performSegue(withIdentifier: "firstSegue", sender: nil)
                } else {
                    print("error: \((error as! NSError).userInfo)")
                    
                    //alert
                    let alertController = UIAlertController(title: "Login Failed", message: "\((error as! NSError).userInfo)" as String?, preferredStyle: .alert)
                    // create a cancel action
                    /*let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                        // handle cancel response here. Doing nothing will dismiss the view.
                    }
                    // add the cancel action to the alertController
                    alertController.addAction(cancelAction)*/
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true, completion:nil)
                }
            }
        }
    }
}

