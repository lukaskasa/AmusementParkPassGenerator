//
//  SeniorGuest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 17.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class SeniorGuest: Guest {
    /// Properties
    let seniorAgeRequirement = 60.0
    
    /**
     Initializes a new Season Pass Guest
     
     - Parameters:
        - firstName: Employees first name
        - lastName: Employees last name
        - streetAddress: Employees street address
        - city: Employees city
        - state: Employees state
        - zipCode: Employees zipCode
     
     - Throws:
     'MissingData.missingDateOfBirth' - if no date of birth is provided
     'MissingData.missingFirstName' - if no first name is provided
     'MissingData.missingLastName' - if no last name is provided'
     
     'InvalidData.invalidDateOfBirth' - if date of birth is not entered in the correct format
     'InvalidData.isNotSenior' - if date of birth does not meet requiremnent
     'InvalidData.invalidfirstName' - if first name doesn't meet the maximum or is of numeric type
     'InvalidData.invalidLastName' - if last name doesn't meet the maximum length or is of numeric type
     
     - Returns: Returns a senior pass guest
     */
    init(firstName: String?, lastName: String?, dateOfBirth: String?) throws {
        super.init(entrantType: .senior)
        
        if dateOfBirth == "" { throw MissingData.missingDateOfBirth }
        if let dateOfBirthDate = dateOfBirth {
            self.dateOfBirth = try? dateOfBirthDate.convertToDate()
            guard let dOB = self.dateOfBirth else { throw InvalidData.invalidDateOfBirth }
            if dOB > Date() { throw InvalidData.invalidDateOfBirth }
            if !isSenior(dateOfBirth: dOB) {
                throw InvalidData.isNotSenior
            }
        }
        if firstName == "" { throw MissingData.missingFirstName }
        if lastName == "" { throw MissingData.missingLastName }
        if firstName!.count > maximumFirstNameChars || (Int(firstName!) != nil) { throw InvalidData.invalidfirstName }
        if lastName!.count > maximumLastNameChars || (Int(lastName!) != nil) { throw InvalidData.invalidLastName }
        
        self.personalInformation = PersonalInformation(firstName: firstName, lastName: lastName, streetAddress: nil, city: nil, state: nil, zipCode: nil)
        
    }
    
    /**
     Checks if the senior/entrant is at least 60 (seniorAgeRequirement) (or the provided child age limit)
     
     - Parameter dateOfBirth: The seniors date of birth
     
     - Returns: Bool
     */
    func isSenior(dateOfBirth: Date) -> Bool {
        let leapYearDay = seniorAgeRequirement * 0.25
        let timeSinceNowInSeconds = TimeInterval((-self.seniorAgeRequirement * 31536000) - leapYearDay * 86400)
        let ageLimit = Date(timeIntervalSinceNow: timeSinceNowInSeconds)
        var isSenior = false
        
        if dateOfBirth <= ageLimit {
            isSenior = true
        }
        
        return isSenior
    }
    
}
