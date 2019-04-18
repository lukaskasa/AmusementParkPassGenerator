//
//  Protocols.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

/*
 
 The core objects such as Entrants and Passes are defined using object oriented approach (class/struct/protocol/inheritance/composition)
 
 */

import Foundation

// MARK: - Park Areas

enum ParkArea: String {
    case amusement = "Amusement Areas"
    case kitchen = "Kitchen Areas"
    case rideControl = "Ride Control Areas"
    case maintanance = "Maintenance Areas"
    case office = "Office Areas"
}

// MARK: - Error Types

enum InvalidData: Error {
    case invalidDateOfBirth
    case invalidfirstName
    case invalidLastName
    case invalidStreetAddress
    case invalidCity
    case invalidState
    case invalidZipCode
}

enum SwipeError: Error {
    case swipedTwice
}

// MARK: - Entrant

protocol EntrantType {
    func accessAreas() -> [ParkArea]
}

protocol Entrant {
    var entrantType: EntrantType { get set }
    
    var dateOfBirth: String { get set }
    
    var firstName: String? { get set }
    var lastName: String? { get set }
    
    var streetAddress: String? { get set }
    var city: String? { get set }
    var state: String? { get set }
    var zipCode: String? { get set }
}

// MARK: - Personal Information

//protocol Nameable {
//    var firstName: String { get set }
//    var lastName: String { get set }
//}
//
//protocol Addressable {
//    var streetAddress: String { get set }
//    var city: String { get set }
//    var state: String { get set }
//    var zipCode: String { get set }
//}

// MARK: - Pass

protocol Generator {
    var childAgeLimit: Double { get }
    func generatePass(for entrant: Entrant) -> Pass
    func isPersonalInfoProvided(entrant: Entrant) -> (Bool, String)
    func convertStringToDate(dateOfBirth: String) -> Date
    func isChildUnderFive(dateOfBirth: Date) -> Bool
}

protocol Validator {
    func validateAreaAccess(_ entrantPass: Pass) -> [String]
    func validateRideAccess(_ entrantPass: Pass) -> [String]
    func validateDiscountAccess(_ entrantPass: Pass) -> [String]
    func validate(_ options: SwipeMethod, with entrantPass: Pass) throws -> [String]
    func isEntrantsBirthday(_ entrantPass: Pass)
}

protocol Pass {
    var firstName: String? { get }
    var lastName: String? { get }
    var dateOfBirth: Date? { get }
    var accessAreas: [ParkArea] { get }
    var rideAccess: String { get }
    var rideLineSkippable: Bool { get }
    var foodDiscount: Double { get }
    var merchDiscount: Double { get }
}
