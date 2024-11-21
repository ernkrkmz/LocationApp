//
//  ViewController.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 5.11.2024.
//

import UIKit
import FirebaseAuth
import SwiftAlertView

class ViewController: UIViewController {

    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGoogleSignin: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func btnLoginClicked(_ sender: Any) {
// TODO: force unwrap at line 35
        if txtEmail.text != "" && txtPassword.text != "" {
            Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { result, error in
                if let error {
                    Alert().showAlert(title: "Error", message: error.localizedDescription)
                }
                else { self.performSegue(withIdentifier: "toTabbar", sender: nil) }
            }
            
        }else {

            SwiftAlertView.show(title: "Empty Fields", message: "Please fill in all fields", buttonTitles: "OK")
            Task{
                await FirebaseManager().fetchLocations()
                
            }
        }
        
    }
    
}

