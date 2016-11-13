//
//  LoginViewController.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/6/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
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
    
    
    //MARK: - IBACtions
    
    @IBAction func loginButton(_ sender: Any) {
        
        // Validate User Input
        guard let username = usernameTextField.text , username != "" else {
            
            // Show Error
            let alert = Utils.createAlert("Login Error", message: "Please provide a username.", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        
        guard let password = passwordTextField.text , password != ""else {
            present(Utils.createAlert("Login Error", message: "Please provide a valid password."), animated: true, completion: nil)
            return
        }
        
        
        // Going to go ahead with the register
        MBProgressHUD.showAdded(to: view, animated: true)
        
        let user = People(email: username, password: password)
        
        UserStore.shared.login(user) { (success, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if success { //post notification to notification center
                self.dismiss(animated: true, completion: nil)
            } else if let error = error {
                self.present(Utils.createAlert(message: error), animated: true, completion: nil)
            }else {
                self.present(Utils.createAlert(message: Constants.JSON.unknownError), animated: true, completion: nil)
            }
        }
        
    }
    

        
        
    }

