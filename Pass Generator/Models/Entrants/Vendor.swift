//
//  Vendor.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 17.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

enum VendorCompany: CaseIterable, EntrantType {
    
    case acme
    case orkin
    case fedex
    case nwElectrical
    
    var title: String {
        switch self {
        case .acme:
            return "Acme"
        case .orkin:
            return "Orkin"
        case .fedex:
            return "Fedex"
        case .nwElectrical:
            return "NW Electrical"
        }
    }
    
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
    
    /// Properties
    let maximumFirstNameChars = 15
    let maximumLastNameChars = 25
    let maximumCityChars = 25
    let maximumStateChars = 15
    let maximumZipCodeLength = 5
    let maximumStreetChars = 30
    
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
    
    var dateOfBirth: Date?
    var dateOfVisit = Date()
    var projectNumber: Int?
    var companyName: String?
    var personalInformation: PersonalInformation?
    
    
    /**
     Initializes a new Season Pass Guest
     
     - Parameters:
        - entrantType: Vendor Entrant Type
        - firstName: Employees first name
        - lastName: Employees last name
        - companyName: Company name
     
     - Throws:
     'MissingData.missingDateOfBirth' - if no date of birth is provided
     'MissingData.missingFirstName' - if no first name is provided
     'MissingData.missingLastName' - if no last name is provided'
     
     'InvalidData.invalidDateOfBirth' - if date of birth is not entered in the correct format
     'InvalidData.invalidfirstName' - if first name doesn't meet the maximum or is of numeric type
     'InvalidData.invalidLastName' - if last name doesn't meet the maximum length or is of numeric type
     
     - Returns: Returns a vendor pass
     */
    init(entrantType: VendorCompany, firstName: String?, lastName: String?, dateOfBirth: String?, companyName: String?) throws {
        self.entrantType = entrantType
        self.companyName = companyName
        
        if firstName == "" { throw MissingData.missingFirstName }
        if lastName == "" { throw MissingData.missingLastName }
        if dateOfBirth == "" { throw MissingData.missingDateOfBirth }
        if let dateOfBirthDate = dateOfBirth {
            self.dateOfBirth = try? dateOfBirthDate.convertToDate()
        }
        guard let dOB = self.dateOfBirth else { throw InvalidData.invalidDateOfBirth }
        if dOB > Date() { throw InvalidData.invalidDateOfBirth }
        
        if firstName!.count > maximumFirstNameChars || (Int(firstName!) != nil) { throw InvalidData.invalidfirstName }
        if lastName!.count > maximumLastNameChars || (Int(lastName!) != nil) { throw InvalidData.invalidLastName }
        
        self.personalInformation = PersonalInformation(firstName: firstName, lastName: lastName, streetAddress: nil, city: nil, state: nil, zipCode: nil)
    }
    
}
