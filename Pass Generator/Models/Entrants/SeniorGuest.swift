//
//  SeniorGuest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 17.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class SeniorGuest: Guest {
    
    init(entrantType: GuestType, firstName: String, lastName: String, dateOfBirth: String?) throws {
        super.init(entrantType: entrantType)
        
        if dateOfBirth == "" { throw MissingData.missingDateOfBirth }
        if let dateOfBirthDate = dateOfBirth {
            self.dateOfBirth = try? dateOfBirthDate.convertToDate()
        }
    }
    
}
