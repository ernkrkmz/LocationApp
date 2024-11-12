//
//  FirebaseManager.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 12.11.2024.
//


import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

final class FirebaseManager {
    
    private let db = Firestore.firestore()
    
    func saveLocation(titleText: String, subtitleText: String , longitude: String, latitude: String) async {
        
        do {
            let id = UUID().uuidString
            guard let email = Auth.auth().currentUser?.email else {
                print("email boş")
                return
            }
            try await db.collection("Locations").addDocument(data: [
                "Email": email,
                "Latitude": latitude,
                "Longitude": longitude,
                "id" : id,
                "title": titleText,
                "subtitle": subtitleText
                
            ])
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    func fetchLocations() async -> [LocationModel]?{
        
        var locationList : [LocationModel] = []
        // TODO: email is equal to degistir
        do{
            let querySnapshot = try await db.collection("Locations").whereField("Email", isEqualTo: "deneme@gmail.com").getDocuments()
            for document in querySnapshot.documents {
//                print(document.data())
                let id = document.get("id") as! String
                let email = document.get("Email") as! String
                let title = document.get("title") as! String
                let subtitle = document.get("subtitle") as! String
                let latitude = document.get("Latitude") as! String
                let longitude = document.get("Longitude") as! String
                
                let location = LocationModel(Email: email, Latitude: latitude, Longitude: longitude, id: id, subtitle: subtitle, title: title)
                locationList.append(location)
                
            }
            return locationList
            
        }catch {
         print("fetch locations error")
        }
        return nil
    }
    
    
}
