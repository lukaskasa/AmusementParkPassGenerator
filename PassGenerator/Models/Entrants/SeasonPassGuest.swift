//
//  SeasonPassGuest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 17.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class SeasonPassGuest: Guest {
    
    init(firstName: String?, lastName: String?, streetAddress: String?, city: String?, state: String?, zipCode: String?) throws {
        super.init(entrantType: .seasonPassHolder)
        self.entrantType = entrantType
        
        if firstName == "" { throw MissingData.missingFirstName }
        if lastName == "" { throw MissingData.missingLastName }
        if streetAddress == "" { throw MissingData.missingStreetAddress }
        if city == "" { throw MissingData.missingCity }
        if state == "" { throw MissingData.missingState }
        if zipCode == "" { throw MissingData.missingZipCode }
        
        if firstName!.count > maximumFirstNameChars || (Int(firstName!) != nil) { throw InvalidData.invalidfirstName }
        if lastName!.count > maximumLastNameChars || (Int(lastName!) != nil) { throw InvalidData.invalidLastName }
        if streetAddress!.count > maximumStreetChars { throw InvalidData.invalidStreetAddress }
        if city!.count > maximumCityChars || (Int(city!) != nil) { throw InvalidData.invalidCity }
        if state!.count > maximumStateChars || (Int(state!) != nil) { throw InvalidData.invalidState }
        if zipCode!.count > maximumZipCodeLength || (Int(zipCode!) == nil) { throw InvalidData.invalidZipCode }
        
        self.personalInformation = PersonalInformation(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
    }
    
}
