//
//  Alert.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 9.11.2024.
//

import UIKit

struct Alert {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    
}
