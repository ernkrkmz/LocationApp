//
//  ListVC.swift
//  LocationApp
//
//  Created by Eren Korkmaz on 19.11.2024.
//

import UIKit

var globalSelectedLocation: LocationModel?

class ListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var locationList : [LocationModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        Task{
            self.locationList = await FirebaseManager().fetchLocations() ?? []
            guard locationList.count > 0 else {
                return
            }
            tableView.reloadData()
        }
        
    }
    
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = locationList[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalSelectedLocation = locationList[indexPath.row]
        performSegue(withIdentifier: "toLocationDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locationList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
}
