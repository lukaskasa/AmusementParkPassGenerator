//
//  VipPass.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 26.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class VipPass: ClassicPass {
    
    let foodDiscountVal = 10.0
    let merchDiscountVal = 20.0
    
    override init(entrantType: EntrantType, firstName: String?, lastName: String?, dateOfBirth: Date?) {
        super.init(entrantType: entrantType, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth)
        self.entrantType = GuestType.vip
        self.foodDiscount = foodDiscountVal
        self.merchDiscount = merchDiscountVal
        self.accessAreas = entrantType.accessAreas()
        self.dateOfBirth = nil
    }
    
    override func discountAccess(type: DiscountType) -> Double {
        isEntrantsBirthday()
        switch  type {
        case .foodDiscount:
            return foodDiscount
        case .merchandiseDiscount:
            return merchDiscount
        }
    }
    
}
