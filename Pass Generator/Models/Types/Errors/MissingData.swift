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
    case missingDateOfBirth = "Missing Date Of Birth!"
    case missingFirstName = "Missing First Name!"
    case missingLastName = "Missing Last Name!"
    case missingStreetAddress = "Missing street address!"
    case missingCity = "Missing city!"
    case missingState = "Missing the state!"
    case missingZipCode = "Missing zip code!"
    case missingDateOfVisit = "Mssing Date of Visit!"
}
