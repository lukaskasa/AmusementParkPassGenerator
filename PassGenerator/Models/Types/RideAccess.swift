//
//  RideAccess.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 01.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Types of Ride Access
enum RideAccess: String {
    case unlimited = "Access all rides"
    case skipLines = "Skip all ride lines"
    case limited = "No access"
}
