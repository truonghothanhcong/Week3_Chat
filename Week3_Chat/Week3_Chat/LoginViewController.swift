//
//  LoginViewController.swift
//  Week3_Chat
//
//  Created by CongTruong on 10/26/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var onSignIn: UIButton!
    
    @IBAction func onSignIn(_ sender: AnyObject) {
        
        PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { (user, error) in
            guard let user = user else {
                //self.displayMessage(error!.userInfo["error"] as! String)
                return
            }
            
            print("Logging in as \(user.username)")
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    @IBAction func onSignUp(_ sender: AnyObject) {
        let user = PFUser()
        user.username = userNameTextField.text
        user.password = passwordTextField.text
        user.email = "1@example.com"
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackground { (succeeded: Bool, error: Error?) in
            if let error = error {
                let errorString = error.localizedDescription
                print(errorString)
            } else {
                print("success")
            }
        }
    }
}
