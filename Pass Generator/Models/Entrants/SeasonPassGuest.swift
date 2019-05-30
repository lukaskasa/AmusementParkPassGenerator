//
//  SeasonPassGuest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 17.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class SeasonPassGuest: Guest {
    
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
     'MissingData.missingFirstName' - if no first name is provided
     'MissingData.missingLastName' - if no last name is provided
     'MissingData.missingStreetAddress' - if no street address is provided
     'MissingData.missingCity' - if no city is provided
     'MissingData.missingState' - if no state is provided
     'MissingData.missingZipCode' - if no zip code is provided
     
     'InvalidData.invalidfirstName' - if first name doesn't meet the maximum or is of numeric type
     'InvalidData.invalidLastName' - if last name doesn't meet the maximum length or is of numeric type
     'InvalidData.invalidStreetAddress' - if the street address doesn't meet the maximum length
     'InvalidData.invalidCity' - if the city doesn't meet the maximum length
     'InvalidData.invalidState' - if the state doesn't meet the maximum length
     'InvalidData.invalidZipCode' - if the state doesn't meet the maximum length and isn't numeric
     
     - Returns: Returns a season pass guest
     */
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
