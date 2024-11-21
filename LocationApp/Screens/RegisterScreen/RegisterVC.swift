//
//  RegisterVC.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 8.11.2024.
//

import UIKit
import FirebaseAuth
class RegisterVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmPass: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnRegisterClicked(_ sender: Any) {

        //    TODO: succes alert did not shown
        if txtEmail.text != "" && txtPassword.text != "" && txtConfirmPass.text != "" {
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { result, error in
                if let error {
                    Alert().showAlert(title: "Error", message: error.localizedDescription)
                } else {
                    Alert().showAlert(title: "Success", message: "User created successfully")
                    self.dismiss(animated: true)
                }
            }
            
            
        } else {
            Alert().showAlert(title: "Error", message: "Please fill all fields")
        }
        
    }
    

}
