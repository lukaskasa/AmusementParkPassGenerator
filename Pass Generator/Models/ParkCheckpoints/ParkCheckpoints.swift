//
//  ParkCheckpoints.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 01.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Park Checkpoint = Park Areas
class ParkAccessArea: ParkCheckpoint {
    
    // Properties
    let checkPointType: ParkCheckpointType = .areaEntrance
    var area: ParkArea
    
    /**
     Initializes a new Park Area object
     
     - Parameters:
     - area: ParkArea type e.g. .amusement
     
     - Returns: An object representing the area of the amusement park
     */
    init(area: ParkArea) {
        self.area = area
    }
    
    /**
     Checks if given pass for the entrant can access the given area
     
     - Parameter pass: Pass for the entrant
     
     - Returns: Bool
     */
    func validate(pass: Pass) -> Bool {
        
        if pass.accessAreas.contains(area) {
            return true
        }
        
        return false
    }
    
}

/// Park Checkpoint - Ride Turnstile
class RideTurnstile: ParkCheckpoint {
    
    // Properties
    let checkPointType: ParkCheckpointType = .rideEntrance
    
    /**
     Checks if given pass for the entrant can access all rides
     
     - Parameter pass: Pass for the entrant
     
     - Returns: Bool
     */
    func validate(pass: Pass) -> Bool {
        if pass.rideAccess.contains(.unlimited) {
            return true
        }
        
        return false
    }
    
}

/// Park Checkpoint - Fast Lane Turnstile
class FastLaneRideTurnstile: ParkCheckpoint {
    
    /// Properties
    let checkPointType: ParkCheckpointType = .rideEntrance
    
    /**
     Checks if given pass for the entrant can skip lines and can access all rides
     
     - Parameter pass: Pass for the entrant
     
     - Returns: Bool
     */
    func validate(pass: Pass) -> Bool {
        if pass.rideAccess.contains(.unlimited) && pass.rideAccess.contains(.skipLines) {
            return true
        }
        
        return false
    }
    
}

/// Park Checkpoint - Park Kiosk Register
class ParkKioskRegister: ParkCheckpoint {
    
    /// Properties
    let checkPointType: ParkCheckpointType = .kioskRegister
    
    /**
     Checks if given pass for the entrant has discounts
     
     - Parameter pass: Pass for the entrant
     
     - Returns: Bool
     */
    func validate(pass: Pass) -> Bool {
        if pass.dicountAccess[0].discountAmount > 0 && pass.dicountAccess[1].discountAmount > 0 {
            return true
        }
        return false
    }
    
}




