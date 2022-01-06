//
//  Toy.swift
//  DoacaoDeBrinquedos
//
//  Created by Aristóteles Júnior on 06/01/22.
//

import Foundation

class Toy {
    var id: String?
    var name: String = ""
    var state: Int = 0
    var donorName: String = ""
    var address: String = ""
    var phoneNumber: String = ""
    
    var conservationState: String {
        switch state {
        case 0:
            return "Novo"
        case 1:
            return "Usado"
        default:
            return "Precisa de reparos"
        }
    }
}
