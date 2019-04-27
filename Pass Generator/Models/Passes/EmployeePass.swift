//
//  EmployeePass.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 25.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class EmployeePass: ClassicPass {
    
    init(entrantType: EntrantType, firstName: String?, lastName: String?) {
        super.init(entrantType: entrantType, firstName: firstName, lastName: lastName, dateOfBirth: nil)
        
        switch entrantType {
        case EmployeeType.manager:
            self.foodDiscount = 25.0
            self.merchDiscount = 25.0
        default:
            self.foodDiscount = 15.0
            self.merchDiscount = 25.0
        }
        
        self.accessAreas = entrantType.accessAreas()
        
    }
    
    override func discountAccess(type: DiscountType) throws -> Double {
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
    
}
