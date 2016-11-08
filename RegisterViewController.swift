//
//  RegisterViewController.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/6/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit
import MBProgressHUD


class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
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
    
    
    //MARK: - IBActions
    @IBAction func registerButtonTapped(_ sender: Any) {
        let avatarBase64 = "Nikki"
        
        
        guard let fullName = usernameTextField.text, fullName != "" else {
            let alert = Utils.createAlert("Login Error", message: "Please provide a Full Name", dismissButtonTitle: "Dismiss")
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let email =  emailTextField.text, email != "" && Utils.isValidEmail(email) else {
            let alert = Utils.createAlert("Login Error", message: "Please provide an email", dismissButtonTitle: "Dismiss")
            present(alert, animated: true, completion: nil)
            return
            
            
        }
        
        guard let password = passwordTextField.text, password != "" else {
            let alert = Utils.createAlert("Login Error", message: "Please provide a password", dismissButtonTitle: "Dismiss")
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let confirmPassword = confirmPasswordTextField.text, confirmPassword == password else {
            let alert = Utils.createAlert("Login Error", message: "Passwords do not match", dismissButtonTitle: "Dismiss")
            present(alert, animated: true, completion: nil)
            return
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        let user = People(email: email, FullName: fullName, AvatarBase64: avatarBase64, Password: password)
        UserStore.shared.register(user) { (success, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if success {
                self.dismiss(animated: true, completion: nil)
            } else if let error = error {
                self.present(Utils.createAlert(message: error), animated: true, completion: nil)
            } else {
                self.present(Utils.createAlert(message: Constants.JSON.unknownError), animated: true, completion: nil)
            }
        }
    }
    

}
