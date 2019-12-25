//
//  ChildGuest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 01.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class ChildGuest: Guest {
    
    // Properties
    let childAgeLimit = 5.0
    
    /**
     Initializes a new Child Guest
     
     - Parameters:
        - dateOfBirth: Date of birth of the child
     
     - Throws:
     'InvalidData.invalidDateOfBirth'- if date provided is not valid.
     'InvalidData.childIsTooOld' - if child is too old to be a child guest
     'MissingData.missingDateOfBirth' - if no date of birth is provided
     
     - Returns: A child guest with access permissions
     */
    init(dateOfBirth: String?) throws {
        super.init(entrantType: .child)
        if dateOfBirth == "" { throw MissingData.missingDateOfBirth }
        if let dateOfBirthDate = dateOfBirth {
            self.dateOfBirth = try? dateOfBirthDate.convertToDate()
            guard let dOB = self.dateOfBirth else { throw InvalidData.invalidDateOfBirth }
            if dOB > Date() { throw InvalidData.invalidDateOfBirth }
            if !isChildUnderFive(dateOfBirth: dOB) {
                throw InvalidData.childIsTooOld
            }
        }
    }
    
    /**
     Checks if the child/entrant is under the age of 5 (or the provided child age limit)
     
     - Parameter dateOfBirth: The childs date of birth
     
     - Returns: Bool
     */
    func isChildUnderFive(dateOfBirth: Date) -> Bool {
        let leapYearDay = childAgeLimit * 0.25
        let timeSinceNowInSeconds = TimeInterval((-self.childAgeLimit * 31536000) - leapYearDay * 86400)
        let ageLimit = Date(timeIntervalSinceNow: timeSinceNowInSeconds)
        var isUnderAgeLimit = false
        
        if dateOfBirth > ageLimit {
            isUnderAgeLimit = true
        }
        
        return isUnderAgeLimit
    }
}
