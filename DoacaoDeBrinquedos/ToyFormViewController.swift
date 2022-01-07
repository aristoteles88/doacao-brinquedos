//
//  ToyFormViewController.swift
//  DoacaoDeBrinquedos
//
//  Created by Aristóteles Júnior on 03/01/22.
//

import UIKit
import Firebase
import SwiftUI

class ToyFormViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var segmentedControlState: UISegmentedControl!
    @IBOutlet weak var textFieldDonor: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var addEditButton: UIButton!
    
    var toy: Toy?
    var firestore: Firestore?
    
    let collection = "toys"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toy = toy {
            title = "Detalhes do Brinquedo"
            textFieldName.text = toy.name
            segmentedControlState.selectedSegmentIndex = toy.state
            textFieldDonor.text = toy.donorName
            textFieldAddress.text = toy.address
            textFieldPhoneNumber.text = toy.phoneNumber
            addEditButton.setTitle("Alterar", for: .normal)
        }
    }

    @IBAction func save(_ sender: UIButton) {
        if toy == nil {
            toy = Toy()
        }
        toy!.name = textFieldName.text!
        toy!.state = segmentedControlState.selectedSegmentIndex
        toy!.donorName = textFieldDonor.text!
        toy!.address = textFieldAddress.text!
        toy!.phoneNumber = textFieldPhoneNumber.text!
        
        if toy!.id == nil {
            firestore?.collection(collection).addDocument(data: toy!.toyData())
        } else {
            firestore?.collection(collection).document(toy!.id!).updateData(toy!.toyData())
        }
        navigationController?.popViewController(animated: true)
        
    }
}

