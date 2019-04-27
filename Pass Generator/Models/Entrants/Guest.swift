//
//  Guest.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

enum GuestType: String, EntrantType {
    case classic = "Normal Guest"
    case vip = "VIP Guest"
    case child = "Child Guest"
    
    func accessAreas() -> [ParkArea] {
        switch self {
        case .classic, .vip, .child:
            return [.amusement]
        }
    }
    
    func rideAccess() -> String {
        switch self {
        case .classic, .child, .vip:
            return "Access all rides"
        }
    }
    
    func canSkipRides() -> Bool {
        switch self {
        case .vip:
            return true
        case .classic, .child:
            return false
        }
    }
}

class Guest: Entrant {

    var dateOfBirth: String?
    let childAgeLimit = 5.0
    
    init(entrantType: GuestType, dateOfBirth: String?) {
        if let dateOfBirth = dateOfBirth {
            self.dateOfBirth = dateOfBirth
        }
        super.init(entrantType: entrantType)
    }
    
    override func generatePass() throws -> Pass {
        switch entrantType {
        case GuestType.classic:
            return ClassicPass(entrantType: entrantType, firstName: nil, lastName: nil, dateOfBirth: nil)
        case GuestType.vip:
            return VipPass(entrantType: entrantType, firstName: nil, lastName: nil, dateOfBirth: nil)
        case GuestType.child:
            guard let dateOfBirth = dateOfBirth else {
                throw InvalidData.invalidDateOfBirth
            }
            if isChildUnderFive(dateOfBirth: convertStringToDate(dateOfBirth: dateOfBirth)) {
                return ChildPass(entrantType: entrantType, firstName: nil, lastName: nil, dateOfBirth: convertStringToDate(dateOfBirth: dateOfBirth))
            } else {
                throw InvalidData.childIsTooOld
            }
        default:
            return ClassicPass(entrantType: entrantType, firstName: nil, lastName: nil, dateOfBirth: nil)
        }
    }
    
    
    func convertStringToDate(dateOfBirth: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let dateOfBirth = formatter.date(from: dateOfBirth) else { fatalError("Could not convert String to date!") }
        return dateOfBirth
    }

    
    func isChildUnderFive(dateOfBirth: Date) -> Bool {
        let leapYearDay = childAgeLimit * 0.25
        let timeSinceNowInSeconds = TimeInterval((-self.childAgeLimit * 31536000) - leapYearDay * 86400)
        let fiveYearsAgo = Date(timeIntervalSinceNow: timeSinceNowInSeconds)
        var isUnderFive = false

        if dateOfBirth > fiveYearsAgo {
            isUnderFive = true
        }

        return isUnderFive
    }
    
}

