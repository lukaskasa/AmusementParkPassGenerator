//
//  Employee.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

enum EmployeeType: EntrantType {
    case foodService
    case rideService
    case maintenance
    case manager
    
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
}

class Employee: Entrant {
    
    // Properties
    var entrantType: EntrantType
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: String?
    
    var dateOfBirth: String = ""
    
    init(entrantType: EmployeeType, firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipCode: String?) {
        self.entrantType = entrantType
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
    
}
