//
//  Entrant.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 20.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Blueprint for an entrant type
protocol Entrant {
    var entrantType: EntrantType { get }
    var accessAreas: [ParkArea] { get }
    var rideAccess: [RideAccess] { get }
    var discountAccess: [DiscountAccess] { get }
    var dateOfBirth: Date? { get set }
    var dateOfVisit: Date { get set }
    var projectNumber: Int? { get set }
    var companyName: String? { get set }
    var personalInformation: PersonalInformation? { get set }
}
