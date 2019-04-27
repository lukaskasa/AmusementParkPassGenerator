//
//  Pass.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 15.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/*

 @lukaskasa I think you have an overall interesting approach, like having a pass generator and a validator.
 Having said that, I would encourage you to turn things around a bit and exploit Polymorphism more, which is a key feature of Object Oriented Design.
 For example, one way to do this is rather than having a validator that validate different kinds of passes, you can have a parent pass object, and various different types of child pass (e.g. employee, normalGuest, class, vip, etc.), and each pass sub-type can then have a swipe method which invoke a validation.
 
 By using this approach, you can essentially ask each pass to go validate themselves.
 So rather than having a big case statement (which usually means the design approach is not quite object oriented :slightly_smiling_face:), you can simply get a pass, and then invoke the swipe and/or validate method that’s associated with that type of pass.
 One other feedback is that, rather than hard coding the discount values (0, 10, 15, 25 etc.) throughout the code, you can declare some constants and assign them instead.
 What you have here is working fine, just that it’ll be very beneficial to pick up a more “true OO” way. It might involve doing some surgery to this existing design, but it’ll be worth it!
 In addition to the awesome Treehouse materials, this is also a good simple reference:
 

 @lukaskasa There are a couple ways to simplify the logic in your app so that you don't have to rely on separate objects
 
 I'd make your Generator object a protocol instead and define a generatePass() method that each object should supply
 that way if you have an `Entrant` instance all you have to do is call `entrant.generatePass()`
 For validating, I'd still keep a PassValidator object...but instead of housing the logic in that object I'd move it to `Employee` and all related objects
 Try to think of it this way...PassValidator shouldn't need to _know_ about the stored properties of a Pass.
 Instead it should just ask a Pass, do you have access to the rides area and the pass should respond yes or no.  Your logic on this portion is nearly there...but I think your methods (in PassValidator) can be cleaned up a tiny bit
 
 */


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



