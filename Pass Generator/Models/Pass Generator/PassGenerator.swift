//
//  PassGenerator.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 14.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class PassGenerator: Generator {
    
    let childAgeLimit: Double = 5
    
    func generatePass(for entrant: Entrant) -> Pass {
        
        var newEntrantPass = EntrantPass(firstName: nil, lastName: nil, dateOfBirth: nil, accessAreas: [.amusement], rideAccess: "Access all rides", rideLineSkippable: false, foodDiscount: 0, merchDiscount: 0)
    
        switch entrant.entrantType {
        case GuestType.classic:
            newEntrantPass = EntrantPass(firstName: nil, lastName: nil, dateOfBirth: nil, accessAreas: entrant.entrantType.accessAreas(), rideAccess: "Access all rides", rideLineSkippable: false, foodDiscount: 0, merchDiscount: 0)
        case GuestType.vip:
            newEntrantPass = EntrantPass(firstName: nil, lastName: nil, dateOfBirth: nil, accessAreas: entrant.entrantType.accessAreas(), rideAccess: "Access all rides", rideLineSkippable: true, foodDiscount: 10, merchDiscount: 20)
        case GuestType.child:
            let dateOfBirth = convertStringToDate(dateOfBirth: entrant.dateOfBirth)
            
            if !self.isChildUnderFive(dateOfBirth: dateOfBirth) {
                print("\(InvalidData.invalidDateOfBirth): Child is too old for the child pass! Child must be under the age of 5.")
            } else {
                newEntrantPass = EntrantPass(firstName: nil, lastName: nil, dateOfBirth: dateOfBirth, accessAreas: entrant.entrantType.accessAreas(), rideAccess: "Access all rides", rideLineSkippable: false, foodDiscount: 0, merchDiscount: 0)
            }
        case EmployeeType.foodService, EmployeeType.rideService, EmployeeType.maintenance:
            
            if !self.isPersonalInfoProvided(entrant: entrant).0 {
                newEntrantPass = EntrantPass(firstName: entrant.firstName, lastName: entrant.lastName, dateOfBirth: nil, accessAreas: entrant.entrantType.accessAreas(), rideAccess: "Access all rides", rideLineSkippable: false, foodDiscount: 15, merchDiscount: 25)
            } else {
               print(self.isPersonalInfoProvided(entrant: entrant).1)
            }
        case EmployeeType.manager:
            if !self.isPersonalInfoProvided(entrant: entrant).0 {
                newEntrantPass = EntrantPass(firstName: entrant.firstName, lastName: entrant.lastName, dateOfBirth: nil, accessAreas: entrant.entrantType.accessAreas(), rideAccess: "Access all rides", rideLineSkippable: false, foodDiscount: 25, merchDiscount: 25)
            } else {
                print(self.isPersonalInfoProvided(entrant: entrant).1)
            }
        default:
            return newEntrantPass
        }
        
        return newEntrantPass
        
    }
    
    func isPersonalInfoProvided(entrant: Entrant) -> (Bool, String) {
        
        var errors = String()
        var isMissing = false
        
        if entrant.firstName == "" {
            errors.append("\(InvalidData.invalidfirstName): Please provide a first name.")
            isMissing = true
        } else if entrant.lastName == "" {
            errors.append("\(InvalidData.invalidLastName): Please provide a last name.")
            isMissing = true
        } else if entrant.streetAddress == "" {
            errors.append("\(InvalidData.invalidStreetAddress): Please provide a street address.")
            isMissing = true
        } else if entrant.city == "" {
            errors.append("\(InvalidData.invalidCity): Please provide a city.")
            isMissing = true
        } else if entrant.state == "" {
            errors.append("\(InvalidData.invalidState): Please provide a state.")
            isMissing = true
        } else if entrant.zipCode == "" {
            errors.append("\(InvalidData.invalidZipCode): Please provide a zip code.")
            isMissing = true
        }
        
        return (isMissing, errors)
        
    }
    
    func convertStringToDate(dateOfBirth: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let dateOfBirth = formatter.date(from: dateOfBirth) else { fatalError("Could not convert String to date!") }
        return dateOfBirth
    }
    
    func isChildUnderFive(dateOfBirth: Date) -> Bool {
        let leapYearDay = childAgeLimit * 0.25
        let timeSinceNowInSeconds = TimeInterval((-self.childAgeLimit * 31536000) - leapYearDay * 86400)
        let fiveYearsAgo = Date(timeIntervalSinceNow: timeSinceNowInSeconds)
        var isUnderFive = false
        
        if dateOfBirth > fiveYearsAgo {
            isUnderFive = true
        }
        
        return isUnderFive
    }
    
}

