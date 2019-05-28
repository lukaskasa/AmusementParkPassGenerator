//
//  EntrantType.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 04.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Blueprint to represent an entrant type
protocol EntrantType {
    var title: String { get }
    func accessAreas() -> [ParkArea]
    func rideAccess() -> [RideAccess]
    func discountAccess() -> [DiscountAccess]
}
