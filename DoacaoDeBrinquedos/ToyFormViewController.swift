//
//  ViewController.swift
//  DoacaoDeBrinquedos
//
//  Created by Aristóteles Júnior on 03/01/22.
//

import UIKit

class ToyFormViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var segmentedControlState: UISegmentedControl!
    @IBOutlet weak var textFieldDonor: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var addEditButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: UIButton) {
    }
    
}

