//
//  Employee.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

enum EmployeeType: String, EntrantType {
    case foodService = "Employee - Food Service"
    case rideService = "Employee - Ride Service"
    case maintenance = "Employee - Maintenance"
    case manager = "Manager"
    
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
        }
    }
    
    func rideAccess() -> String {
        switch self {
        case .foodService, .rideService, .maintenance, .manager:
            return "Access all rides"
        }
    }
    
}

class Employee: Entrant, Nameable, Addressable {
    
    // Properties
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    
    init(entrantType: EmployeeType, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        super.init(entrantType: entrantType)
    }
    
    override func generatePass() throws -> Pass {
        
        if firstName == "" { throw MissingData.missingFirstName}
        if lastName == "" { throw MissingData.missingLastName }
        if streetAddress == "" { throw MissingData.missingStreetAddress }
        if city == "" { throw MissingData.missingCity }
        if state == "" { throw MissingData.missingState }
        if zipCode == "" { throw MissingData.missingZipCode }
        
        return EmployeePass(entrantType: entrantType, firstName: firstName, lastName: lastName)
    }
    
}
