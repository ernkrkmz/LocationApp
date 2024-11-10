//
//  SettingsVC.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 10.11.2024.
//

import UIKit
import FirebaseAuth

class SettingsVC: UIViewController {

    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            print("logged out")
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        } catch {
            Alert().showAlert(title: "Log out error", message: "")
        }
        
    }
    
}
