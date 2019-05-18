//
//  Vendor.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 17.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

enum VendorCompany: String, EntrantType {
    case acme = "Acme"
    case orkin = "Orkin"
    case fedex = "Fedex"
    case nwElectrical = "NW Electrical"
    
    func accessAreas() -> [ParkArea] {
        switch self {
        case .acme:
            return [.kitchen]
        case .orkin:
            return [.amusement, .rideControl, .kitchen]
        case .fedex:
            return [.maintanance, .office]
        case .nwElectrical:
            return [.amusement, .rideControl, .kitchen, .maintanance, .office]
        }
    }
    
    func rideAccess() -> [RideAccess] {
        return [.limited]
    }
    
    func discountAccess() -> [DiscountAccess] {
        return [.foodDiscount(percentage: 0), .merchandiseDiscount(percentage: 0)]
    }
}

class Vendor: Entrant {
    
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
    
    var companyName: String
    var dateOfBirth: Date?
    var dateOfVisit: Date?
    var personalInformation: PersonalInformation?
    
    init(entrantType: VendorCompany, firstName: String, lastName: String, dateOfBirth: String?, dateOfVisit: String?) throws {
        self.entrantType = entrantType
        self.companyName = entrantType.rawValue
        
        if firstName == "" { throw MissingData.missingFirstName }
        if lastName == "" { throw MissingData.missingLastName }
        if dateOfBirth == "" { throw MissingData.missingDateOfBirth }
        if dateOfVisit == "" { throw MissingData.missingDateOfVisit }
        if let dateOfBirthDate = dateOfBirth, let dateOfVisitDate = dateOfVisit {
            self.dateOfBirth = try? dateOfBirthDate.convertToDate()
            self.dateOfVisit = try? dateOfVisitDate.convertToDate()
        }
    }
    
}
