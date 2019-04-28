//
//  Protocols.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

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

enum MissingData: String, Error {
    case missingDateOfBirth = "Missing Date Of Birth!"
    case missingFirstName = "Missing First Name!"
    case missingLastName = "Missing Last Name!"
    case missingStreetAddress = "Missing street address!"
    case missingCity = "Missing city!"
    case missingState = "Missing the state!"
    case missingZipCode = "Missing zip code!"
}

enum InvalidData: Error {
    case invalidDateOfBirth
    case childIsTooOld
    case invalidfirstName
    case invalidLastName
    case invalidStreetAddress
    case invalidCity
    case invalidState
    case invalidZipCode
}

enum SwipeError: Error {
    case swipedTooOften
}

// MARK: - Entrant

protocol EntrantType {
    func accessAreas() -> [ParkArea]
    func rideAccess() -> String
}

// MARK: - Personal Information

protocol Nameable {
    var firstName: String { get set }
    var lastName: String { get set }
}

protocol Addressable {
    var streetAddress: String { get set }
    var city: String { get set }
    var state: String { get set }
    var zipCode: String { get set }
}

// MARK: - Pass

protocol Generatable {
    func generatePass() throws -> Pass
}

enum RideAccess: String {
    case unlimited = "Access all rides"
    case limited = "No access"
}

enum DiscountType {
    case foodDiscount
    case merchandiseDiscount
}

enum SwipeMethod {
    case area
    case ride
    case dicount
}

protocol Pass {
    var firstName: String? { get }
    var lastName: String? { get }
    var dateOfBirth: Date? { get }
    var accessAreas: [ParkArea] { get }
    func validateAreaAccess(area: ParkArea) throws -> Bool
    func hasRideAccess() throws -> Bool
    func discountAccess(type: DiscountType) throws -> Double
}

