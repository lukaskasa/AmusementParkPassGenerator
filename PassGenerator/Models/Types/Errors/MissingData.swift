//
//  MissingData.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 01.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Error type to represent if data necessary data is missing
enum MissingData: String, Error {
    case missingDateOfBirth = "Please enter a Date Of Birth!"
    case missingFirstName = "Please enter a First Name!"
    case missingLastName = "Please enter a Last Name!"
    case missingStreetAddress = "Please enter a street address!"
    case missingCity = "Please enter a city!"
    case missingState = "Please enter a the state!"
    case missingZipCode = "Please enter a zip code!"
    case missingDateOfVisit = "Please enter a Date of Visit!"
    case missingProjectNumber = "Please enter a Project Number!"
    case missingCompanyName = "Please enter a company name!"
}
