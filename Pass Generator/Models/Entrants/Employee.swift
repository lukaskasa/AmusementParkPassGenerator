//
//  Employee.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Employee Type of Entrant Type
enum EmployeeType: EntrantType {
    
    case foodService
    case rideService
    case maintenance
    case manager
    case contractEmployee(projectNumber: Int)
    
    func accessAreas() -> [ParkArea] {
        switch self {
        case .foodService:
            return [.amusement, .kitchen]
        case .rideService:
            return [.amusement, .rideControl]
        case .maintenance:
            return [.amusement, .kitchen, .rideControl, .maintanance]
        case .manager:
            return [.amusement, .kitchen, .rideControl, .maintanance, .office]
        case .contractEmployee(projectNumber:1001):
            return [.amusement, .rideControl]
        case .contractEmployee(projectNumber:1002):
            return [.amusement, .rideControl, .maintanance]
        case .contractEmployee(projectNumber:1003):
            return [.amusement, .rideControl, .kitchen, .maintanance, .office]
        case .contractEmployee(projectNumber:2001):
            return [.office]
        case .contractEmployee(projectNumber:2002):
            return [.kitchen, .maintanance]
        default:
            return []
        }
    }
    
    func rideAccess() -> [RideAccess] {
        switch self {
        case .foodService, .rideService, .maintenance, .manager:
            return [.unlimited]
        default:
            return [.limited]
        }
    }
    
    func discountAccess() -> [DiscountAccess] {
        switch self {
        case .foodService, .rideService, .maintenance:
            return [.foodDiscount(percentage: 15.0), .merchandiseDiscount(percentage: 25.0)]
        case .manager:
            return [.foodDiscount(percentage: 25.0), .merchandiseDiscount(percentage: 25.0)]
        default:
            return [.foodDiscount(percentage: 0), .merchandiseDiscount(percentage: 0)]
        }
    }
    
}

/// Employee object - represents the entrants for food-, ride service, maintenance and manage employee types
class Employee: Entrant {
    
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
    
    var dateOfBirth: Date?
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
    init(entrantType: EmployeeType, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String) throws {
        self.entrantType = entrantType
        
        if firstName == "" { throw MissingData.missingFirstName }
        if lastName == "" { throw MissingData.missingLastName }
        if streetAddress == "" { throw MissingData.missingStreetAddress }
        if city == "" { throw MissingData.missingCity }
        if state == "" { throw MissingData.missingState }
        if zipCode == "" { throw MissingData.missingZipCode }
        
        self.personalInformation = PersonalInformation(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
    }
    
}
