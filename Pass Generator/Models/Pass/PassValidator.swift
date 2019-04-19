//
//  PassValidator.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 14.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

enum SwipeMethod {
    case areaAccess
    case rideAccess
    case discountAccess
}

class PassValidator_OLD {
    
    var swiped = false
    
    func validateAreaAccess(_ entrantPass: Pass) -> [String] {
        
        var permittedAccessAreas = [String]()
        
        for area in entrantPass.accessAreas {
           permittedAccessAreas.append(area.rawValue)
        }
        
        self.isEntrantsBirthday(entrantPass)
        
        return permittedAccessAreas
    }
    
    func validateRideAccess(_ entrantPass: Pass) -> [String] {
        
        var permittedRideAccess = [String]()
        
        permittedRideAccess.append(entrantPass.rideAccess)
        
        if entrantPass.rideLineSkippable {
            permittedRideAccess.append("Skip all ride lines")
        }
        
        self.isEntrantsBirthday(entrantPass)
        
        return permittedRideAccess
    }
    
    func validateDiscountAccess(_ entrantPass: Pass) -> [String] {
    
        var discountAccess = [String]()
        
        if entrantPass.foodDiscount > 0 {
            discountAccess.append("\(entrantPass.foodDiscount)% discount on food")
        }
        
        if entrantPass.merchDiscount > 0 {
            discountAccess.append("\(entrantPass.merchDiscount)% discount on merchandise")
        }
        
        self.isEntrantsBirthday(entrantPass)
        
        return discountAccess
        
    }
    
    func isEntrantsBirthday(_ entrantPass: Pass) {
        guard let dateOfBirth = entrantPass.dateOfBirth else { return }
        let myCalendar = Calendar(identifier: .gregorian)
        let today = myCalendar.dateComponents([.month, .day], from: Date())
        let birthday = myCalendar.dateComponents([.month, .day], from: dateOfBirth)

        if (today.month == birthday.month) && (today.day == birthday.day) {
            print("Happy Birthday! Enjoy your stay at the park!")
        }
    }
    
    func validate(_ options: SwipeMethod, with entrantPass: Pass) throws -> [String] {
        var validOutput = [String]()
        
        if !swiped {
            swiped = true
            print("Swipe lock enabled: wait 5s")
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.swiped = false
                print("Swipe lock disabled")
            }
            switch options {
            case .areaAccess:
                validOutput = self.validateAreaAccess(entrantPass)
            case .rideAccess:
                validOutput = self.validateRideAccess(entrantPass)
            case .discountAccess:
                validOutput = self.validateDiscountAccess(entrantPass)
            }
        } else {
            throw SwipeError.swipedTwice
        }

        return validOutput
    }
    
    
}
