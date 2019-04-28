//
//  Pass.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 15.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class ClassicPass: Pass {
    let delay = 5.0
    
    var areaAccessSwiped = false,
    rideAccessSwiped = false,
    discountAccessSwiped = false
    
    var entrantType: EntrantType
    
    var firstName: String?
    var lastName: String?
    var dateOfBirth: Date?
    var accessAreas: [ParkArea]
    
    var foodDiscount: Double
    var merchDiscount: Double
    
    init(entrantType: EntrantType, firstName: String?, lastName: String?, dateOfBirth: Date?) {
        self.entrantType = entrantType
        self.firstName = firstName ?? "None"
        self.lastName = lastName ?? "None"
        self.accessAreas = entrantType.accessAreas()
        
        self.foodDiscount = 0
        self.merchDiscount = 0
        
        if let dateOfBirth = dateOfBirth {
            self.dateOfBirth = dateOfBirth
        }
    
    }
    
    func validateAreaAccess(area: ParkArea) throws -> Bool {
        isEntrantsBirthday()
        if areaAccessSwiped { throw SwipeError.swipedTooOften }
        areaAccessSwiped = true
        delaySwipe(of: .area)
        if accessAreas.contains(area) {
            return true
        }
        return false
    }
    
    func hasRideAccess() throws -> Bool {
        isEntrantsBirthday()
        if rideAccessSwiped { throw SwipeError.swipedTooOften }
        rideAccessSwiped = true
        delaySwipe(of: .ride)
        return true
    }
    
    func discountAccess(type: DiscountType) throws -> Double {
        isEntrantsBirthday()
        if discountAccessSwiped { throw SwipeError.swipedTooOften }
        discountAccessSwiped = true
        delaySwipe(of: .dicount)
        switch  type {
        case .foodDiscount:
            return foodDiscount
        case .merchandiseDiscount:
            return merchDiscount
        }
    }
    
    func isEntrantsBirthday() {
        guard let dateOfBirth = dateOfBirth else { return }
        let myCalendar = Calendar(identifier: .gregorian)
        let today = myCalendar.dateComponents([.month, .day], from: Date())
        let birthday = myCalendar.dateComponents([.month, .day], from: dateOfBirth)

        if (today.month == birthday.month) && (today.day == birthday.day) {
            print("Happy Birthday! Enjoy your stay at the park!")
        }
    }
    
    func delaySwipe(of swipe: SwipeMethod) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            switch swipe {
            case .area:
                self.areaAccessSwiped = !self.areaAccessSwiped
            case .ride:
                self.rideAccessSwiped = !self.rideAccessSwiped
            case .dicount:
                self.discountAccessSwiped = !self.discountAccessSwiped
            }
            print("Swipe lock disabled")
        }
    }
    
}



