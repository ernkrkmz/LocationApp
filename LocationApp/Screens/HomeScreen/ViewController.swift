//
//  ViewController.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 5.11.2024.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGoogleSignin: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Auth.auth().currentUser?.email)
        
    }

    @IBAction func btnLoginClicked(_ sender: Any) {
        if txtEmail.text != "" && txtPassword.text != "" {
            Auth.auth().signIn(withEmail: "deneme@gmail.com", password: "12345") { result, error in
                if let error {
                    print(error.localizedDescription)
                    Alert().showAlert(title: "Error", message: error.localizedDescription)
                } else {
                    print("Login Success")
                    self.performSegue(withIdentifier: "toTabbar", sender: nil)
                }
            }
        }else {
            Alert().showAlert(title: "Empty Fields", message: "Please fill in all fields")
        }
        
    }
    
}

