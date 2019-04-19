//
//  Pass.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 15.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation


struct EntrantPass: Pass {
    var firstName: String?
    var lastName: String?
    
    var dateOfBirth: Date?
    
    var accessAreas: [ParkArea]
    
    var rideAccess: String
    var rideLineSkippable: Bool
    
    var foodDiscount: Double
    var merchDiscount: Double
}
