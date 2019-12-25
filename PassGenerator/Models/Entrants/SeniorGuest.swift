//
//  SeniorGuest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 17.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class SeniorGuest: Guest {
    
    let seniorAgeRequirement = 60.0
    
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
