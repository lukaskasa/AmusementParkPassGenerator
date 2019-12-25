//
//  DiscountAccess.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 01.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Types of discount at the park
enum DiscountAccess {
    case foodDiscount(percentage: Double)
    case merchandiseDiscount(percentage: Double)
    
    /// Computed property to return the amount of discount from the associative value
    var discountAmount: Double {
        switch self {
        case .foodDiscount(let percentage):
            return percentage
        case .merchandiseDiscount(let percentage):
            return percentage
        }
    }
}
