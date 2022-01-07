//
//  ToyTableViewController.swift
//  DoacaoDeBrinquedos
//
//  Created by Aristóteles Júnior on 06/01/22.
//

import UIKit
import Firebase

class ToysTableViewController: UITableViewController {
    
    let collection = "toys"
    var toys: [Toy] = []
    lazy var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()
    var listener: ListenerRegistration!

    func loadToysList() {
        listener = firestore.collection(collection).order(by: "name", descending: false).addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
            if let error = error {
                print(error)
            } else {
                guard let snapshot = snapshot else {return}
                print ("Total de documentos alterados: \(snapshot.documentChanges.count)")
                if snapshot.metadata.isFromCache || snapshot.documentChanges.count > 0{
                    self.showItemsFrom(snapshot)
                }
            }
        })
        
    }
    
    func showItemsFrom(_ snapshot: QuerySnapshot) {
        toys.removeAll()
        for document in snapshot.documents {
            let data = document.data()
            if let name = data["name"] as? String,
               let state = data["state"] as? Int,
               let donorName = data["donorName"] as? String,
               let address = data["address"] as? String,
               let phoneNumber = data["phoneNumber"] as? String {
                let toy = Toy()
                toy.name = name
                toy.state = state
                toy.donorName = donorName
                toy.address = address
                toy.phoneNumber = phoneNumber
                toy.id = document.documentID
                toys.append(toy)
            }
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toyFormViewController = segue.destination as? ToyFormViewController{
            toyFormViewController.firestore = firestore
            if let row = tableView.indexPathForSelectedRow?.row {
                toyFormViewController.toy = toys[row]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadToysList()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let toy = toys[indexPath.row]
        cell.textLabel?.text = toy.name
        cell.detailTextLabel?.text = toy.conservationState

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toy = toys[indexPath.row]
            firestore.collection(collection).document(toy.id!).delete()
        }
    }
}
