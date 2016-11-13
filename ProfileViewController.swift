//
//  ProfileViewController.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/13/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    var gestureRecognizer: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = UserStore.shared.user {
            usernameTextField.text = user.userName
            
            if let image = Utils.stringToImage(str: user.avatarBase64) {
                profileImageView.image = image
                addGestureRecognizer()
            } else {
                profileImageView.isHidden = true
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGestureRecognizer(){
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        profileImageView.addGestureRecognizer(gestureRecognizer)
    }
    func viewImage(){
        if let image = profileImageView.image{
            UserStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "")
            present(viewController, animated: true, completion: nil)
        }
    }
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    //MARK: - IBActions
    @IBAction func saveTapped(_ sender: Any) {
        
        guard let fullName = usernameTextField.text, fullName != "" else {
            //show error
            let alert = Utils.createAlert("Error!", message: "Please provide a valid username.", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            //need return or it just keeps on going on
            return
        }
        let avatarImage = Utils.imageToString(image: profileImageView.image)
        print("Avatar Size: \(avatarImage?.characters.count)")
        let user = People(email: fullName, password: avatarImage!)
        
        
        WebServices.shared.postObject(user) { (object, error) in
            if error == nil{
                UserStore.shared.user?.fullName = fullName
                UserStore.shared.user?.avatarBase64 = avatarImage
                let alert = Utils.createAlert("Success", message: "Image chosen.", dismissButtonTitle: "Close")
                self.present(alert, animated: true, completion: nil)
                
            }else{
                let alert = Utils.createAlert("Error.", message: "A problem occurred.", dismissButtonTitle: "Close")
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
        }
        
    }
    
    
    
    
    
    @IBAction func choosePhoto(_ sender: Any) {
        
        let alert = UIAlertController(title: "Picture", message: "Choose picture.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action) in self.showPicker(.camera)}))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action) in self.showPicker(.photoLibrary)}))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveProfileDetail(_ segue: UIStoryboardSegue) {
        
    }
    
}




extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            let maxSize: CGFloat = 128
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height:newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width:maxSize, height:newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            profileImageView.image = resizedImage
            
            profileImageView.isHidden = false
            if gestureRecognizer != nil {
                profileImageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
    }
}


