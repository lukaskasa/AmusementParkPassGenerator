//
//  Guest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Guest Type of Entrant Type
enum GuestType: CaseIterable, EntrantType {

    case child
    case classic
    case seasonPassHolder
    case senior
    case vip
    
    var title: String {
        switch self {
        case .child:
            return "Child"
        case .classic:
            return "Adult"
        case .seasonPassHolder:
            return "Season"
        case .senior:
            return "Senior"
        case .vip:
            return "VIP"
        }
    }
    
    func accessAreas() -> [ParkArea] {
        switch self {
        case .classic, .vip, .child, .seasonPassHolder, .senior:
            return [.amusement]
        }
    }
    
    func rideAccess() -> [RideAccess] {
        switch self {
        case .classic, .child:
            return [.unlimited]
        case .vip, .seasonPassHolder, .senior:
            return [.unlimited, .skipLines]
        }
    }
    
    func discountAccess() -> [DiscountAccess] {
        switch self {
        case .classic, .child:
            return [.foodDiscount(percentage: 0), .merchandiseDiscount(percentage: 0)]
        case .vip, .seasonPassHolder:
            return [.foodDiscount(percentage: 10.0), .merchandiseDiscount(percentage: 20.0)]
        case .senior:
            return [.foodDiscount(percentage: 10.0), .merchandiseDiscount(percentage: 10.0)]
        }
    }
}

/// Guest object - represents the entrants for classic and vip
class Guest: Entrant {

    /// Properties
    let maximumFirstNameChars = 15
    let maximumLastNameChars = 25
    let maximumCityChars = 25
    let maximumStateChars = 15
    let maximumZipCodeLength = 5
    let maximumStreetChars = 40
    
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
    var projectNumber: Int?
    var companyName: String?
    var dateOfVisit = Date()
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

