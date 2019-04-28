//
//  Pass.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 15.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class ClassicPass: Pass {
    var swiped = false
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
    
    func validateAreaAccess(area: ParkArea) -> Bool {
        isEntrantsBirthday()
        if accessAreas.contains(area) {
            return true
        }
        return false
    }
    
    func hasRideAccess() -> Bool {
        isEntrantsBirthday()
        return true
    }
    
    func discountAccess(type: DiscountType) throws -> Double {
        if swiped { throw SwipeError.swipedTooOften }
        delaySwipe()
        isEntrantsBirthday()
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
    
    func delaySwipe() {
        swiped = true
        if swiped {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.swiped = false
                print("Swipe lock disabled")
            }
        }
    }
    
}



