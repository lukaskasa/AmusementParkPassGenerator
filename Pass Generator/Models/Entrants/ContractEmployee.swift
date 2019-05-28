//
//  ContractEmployee.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 25.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation


enum ContractEmployeeType: EntrantType {
    case contractEmployee(projectNumber: Int)
    
    var title: String {
        return "Contractor"
    }
    
    func accessAreas() -> [ParkArea] {
        switch self {
        case .contractEmployee(projectNumber: 1001):
            return [.amusement, .rideControl]
        case .contractEmployee(projectNumber: 1002):
            return [.amusement, .rideControl, .maintanance]
        case .contractEmployee(projectNumber: 1003):
            return [.amusement, .rideControl, .kitchen, .maintanance, .office]
        case .contractEmployee(projectNumber: 2001):
            return [.office]
        case .contractEmployee(projectNumber: 2002):
            return [.kitchen, .maintanance]
        default:
            return []
        }
    }
    
    func rideAccess() -> [RideAccess] {
        return [.limited]
    }
    
    func discountAccess() -> [DiscountAccess] {
        return [.foodDiscount(percentage: 0.0), .merchandiseDiscount(percentage: 0.0)]
    }
}

class ContractEmployee: Employee {
    
    let maximumProjectNumber = 9999
    
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipCode: String?, projectNumber: String?) throws {
    if projectNumber == ""  { throw MissingData.missingProjectNumber }
    guard let number = projectNumber else { throw InvalidData.invalidProjectNumber }
    if number.count > maximumProjectNumber || (Int(number) == nil) { throw InvalidData.invalidProjectNumber }
        
    try super.init(entrantType: .contractor, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
        self.projectNumber = Int(number)
        self.entrantType = ContractEmployeeType.contractEmployee(projectNumber: self.projectNumber ?? 0)
    }
    
}
