//
//  SeasonPassGuest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 17.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class SeasonPassGuest: Guest {
    
    init(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String) {
        super.init(entrantType: .seasonPassHolder)
        self.entrantType = entrantType
        self.personalInformation = PersonalInformation(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
    }
    
}
