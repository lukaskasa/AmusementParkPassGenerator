//
//  InvalidData.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 01.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Error type to represenet if the given data is invalid
enum InvalidData: String, Error {
    case invalidDateOfBirth = "Date of Birth entered is invalid! Use the correct Format! (MM/DD/YYYY)"
    case childIsTooOld = "Child is too old!"
    case isNotSenior = "Person is not old enough for the senior pass!"
    case invalidfirstName = "The first name entered is invalid! (15 characters max and no numerical values)"
    case invalidLastName = "The last name entered is invalid! (25 characters max and no numerical values)"
    case invalidStreetAddress = "The Street Address ist invalid! (30 characters max) "
    case invalidCity = "The city entered is invalid! (25 characters max and no numerical values)"
    case invalidState = "The state entered is invalid! (20 characters max and no numerical values)"
    case invalidZipCode = "The zip code entered is invalid! Only numeric characters are allowed!"
    case invalidProjectNumber = "Please enter only a four digit number!"
}
