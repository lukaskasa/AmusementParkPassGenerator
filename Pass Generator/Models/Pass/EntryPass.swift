//
//  EntryPass.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 15.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Blueprint for a pass to the amusement park
protocol Pass {
    var entrant: Entrant? { get set }
    var accessAreas: [ParkArea] { get }
    var rideAccess: [RideAccess] { get }
    var dicountAccess: [DiscountAccess] { get }
    var isLocked: Bool { get set }
    func swipePass(at location: ParkCheckpoint) throws -> Bool
}

/// Pass object - used to enter the amusement park, enter its areas, enter rides and get discounts on goods
class EntryPass: Pass {
    
    var entrant: Entrant?
    var accessAreas: [ParkArea]
    var rideAccess: [RideAccess]
    var dicountAccess: [DiscountAccess]
    
    let swipeDelay = 5.0
    var isLocked = false
    
    /**
     Initializes a new Park Entry Pass
     
     - Parameters:
     - entrant: Entrant (Guest, ChildGuest or Employee)
     
     - Returns: A Pass for the given entrant
     */
    init(for entrant: Entrant) {
        self.entrant = entrant
        self.accessAreas = entrant.accessAreas
        self.rideAccess = entrant.rideAccess
        self.dicountAccess = entrant.discountAccess
    }
    
    /**
     Validates entry at a given location in the amusement park
     
     - Parameter location: The checkpoint at the park
     
     - Returns: Bool
     */
    func swipePass(at location: ParkCheckpoint) throws -> Bool {
        if isLocked && (location.checkPointType == .rideEntrance) {
            throw SwipeError.swipedTooOften
        }
        
        if (location.checkPointType == .rideEntrance) {
            isLocked = true
            DispatchQueue.main.asyncAfter(deadline: .now() + swipeDelay) {
                // Swipe lock disabled
                self.isLocked = false
            }
        }
        
        return location.validate(pass: self)
    }
    
    /**
     Check if it is the entrants birthday
     
     - Returns: Bool
     */
    func isEntrantsBirthday() -> Bool {
        guard let dateOfBirth = entrant?.dateOfBirth else { return false }
        let myCalendar = Calendar(identifier: .gregorian)
        let today = myCalendar.dateComponents([.month, .day], from: Date())
        let birthday = myCalendar.dateComponents([.month, .day], from: dateOfBirth)

        if (today.month == birthday.month) && (today.day == birthday.day) {
            return true
        }
        
        return false
    }

}
