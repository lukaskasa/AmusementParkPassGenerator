//
//  InvalidData.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 01.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Error type to represenet if the given data is invalid
enum InvalidData: Error {
    case invalidDateOfBirth
    case childIsTooOld
    case invalidfirstName
    case invalidLastName
    case invalidStreetAddress
    case invalidCity
    case invalidState
    case invalidZipCode
}
