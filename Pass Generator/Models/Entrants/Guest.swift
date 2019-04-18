//
//  Guest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

enum GuestType: EntrantType {
    case classic
    case vip
    case child
    
    func accessAreas() -> [ParkArea] {
        switch self {
        case .classic, .vip, .child:
            return [.amusement]
        }
    }
}

class Guest: Entrant {

    // Properties
    var entrantType: EntrantType
    var dateOfBirth: String
    
    var firstName: String? = nil
    var lastName: String? = nil
    var streetAddress: String? = nil
    var city: String? = nil
    var state: String? = nil
    var zipCode: String? = nil
    
    init(entrantType: GuestType, dateOfBirth: String) {
        self.entrantType = entrantType
        self.dateOfBirth = dateOfBirth
//
//        if let dateOfBirth = self.dateOfBirth {
//            self.dateOfBirth = dateOfBirth
//        }
    }
    
}
