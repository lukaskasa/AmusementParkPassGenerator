//
//  Employee.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Employee Type of Entrant Type
enum EmployeeType: CaseIterable, EntrantType {
    
    case foodService
    case rideService
    case maintenance
    case contractor
    case manager
    
    var title: String {
        switch self {
        case .foodService:
            return "Food"
        case .rideService:
            return "Ride"
        case .maintenance:
            return "Maintenance"
        case .contractor:
            return "Contractor"
        case .manager:
            return "Manager"
        }
    }
    
    func accessAreas() -> [ParkArea] {
        switch self {
        case .foodService:
            return [.amusement, .kitchen]
        case .rideService:
            return [.amusement, .rideControl]
        case .maintenance:
            return [.amusement, .kitchen, .rideControl, .maintanance]
        case .contractor:
            return []
        case .manager:
            return [.amusement, .kitchen, .rideControl, .maintanance, .office]
        }
    }
    
    func rideAccess() -> [RideAccess] {
        switch self {
        case .foodService, .rideService, .maintenance, .manager:
            return [.unlimited]
        case .contractor:
            return []
        }
    }
    
    func discountAccess() -> [DiscountAccess] {
        switch self {
        case .foodService, .rideService, .maintenance:
            return [.foodDiscount(percentage: 15.0), .merchandiseDiscount(percentage: 25.0)]
        case .manager:
            return [.foodDiscount(percentage: 25.0), .merchandiseDiscount(percentage: 25.0)]
        case .contractor:
            return [.foodDiscount(percentage: 0.0), .merchandiseDiscount(percentage: 0.0)]
        }
    }
    
}

/// Employee object - represents the entrants for food-, ride service, maintenance and manage employee types
class Employee: Entrant {
    
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
    
    var dateOfBirth: Date?
    var projectNumber: Int?
    var companyName: String?
    var dateOfVisit = Date()
    var personalInformation: PersonalInformation?
    
    /**
     Initializes a new Employee object
     
     - Parameters:
     - entrantType: EmployeeType (kitchenService, rideService, maintenance, manager)
     - firstName: Employees first name
     - lastName: Employees last name
     - streetAddress: Employees street address
     - city: Employees city
     - state: Employees state
     - zipCode: Employees zipCode
     
     - Throws:
     'MissingData.missingFirstName'- if no first name is provided
     'MissingData.missingLastName' - if not last name is provded
     'MissingData.missingStreetAddress' - if no street address is provided
     'MissingData.missingCity' - if no city is provided
     'MissingData.missingState' - if no state is provided
     'MissingData.missingZipCode' - if no zip code is provided
     
     
     - Returns: A child guest with access permissions
     */
    init(entrantType: EmployeeType, firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipCode: String?) throws {
        self.entrantType = entrantType
        
        if firstName == "" { throw MissingData.missingFirstName }
        if lastName == "" { throw MissingData.missingLastName }
        if streetAddress == "" { throw MissingData.missingStreetAddress }
        if city == "" { throw MissingData.missingCity }
        if state == "" { throw MissingData.missingState }
        if zipCode == "" { throw MissingData.missingZipCode }
        
        if firstName!.count > maximumFirstNameChars || (Int(firstName!) != nil) { throw InvalidData.invalidfirstName }
        if lastName!.count > maximumLastNameChars || (Int(lastName!) != nil) { throw InvalidData.invalidLastName }
        if streetAddress!.count > maximumStreetChars { throw InvalidData.invalidStreetAddress }
        if city!.count > maximumCityChars || (Int(city!) != nil) { throw InvalidData.invalidCity }
        if state!.count > maximumStateChars || (Int(state!) != nil) { throw InvalidData.invalidState }
        if zipCode!.count > maximumZipCodeLength || (Int(zipCode!) == nil) { throw InvalidData.invalidZipCode }
        
        self.personalInformation = PersonalInformation(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
    }
    
}
