//
//  Guest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Guest Type of Entrant Type
enum GuestType: String, EntrantType {

    case classic = "Normal Guest"
    case vip = "VIP Guest"
    case child = "Child Guest"
    
    func accessAreas() -> [ParkArea] {
        switch self {
        case .classic, .vip, .child:
            return [.amusement]
        }
    }
    
    func rideAccess() -> [RideAccess] {
        switch self {
        case .classic, .child:
            return [.unlimited]
        case .vip:
            return [.unlimited, .skipLines]
        }
    }
    
    func discountAccess() -> [DiscountAccess] {
        switch self {
        case .classic, .child:
            return [.foodDiscount(percentage: 0), .merchandiseDiscount(percentage: 0)]
        case .vip:
            return [.foodDiscount(percentage: 10.0), .merchandiseDiscount(percentage: 20.0)]
        }
    }
}

/// Guest object - represents the entrants for classic and vip
class Guest: Entrant {

    /// Properties
    var entrantType: EntrantType
    
    var accessAreas: [ParkArea] {
        return entrantType.accessAreas()
    }

    var rideAccess: [RideAccess] {
        return entrantType.rideAccess()
    }

    var discountAccess: [DiscountAccess] {
        return entrantType.discountAccess()
    }
    
    var personalInformation: PersonalInformation?
    
    var dateOfBirth: Date?
    
    /**
     Initializes a new Guest object
     
     - Parameters:
     - entrantType: The type of guest type
     
     - Returns: A guest object with access permissions
     */
    init(entrantType: GuestType) {
        self.entrantType = entrantType
    }
    
}

