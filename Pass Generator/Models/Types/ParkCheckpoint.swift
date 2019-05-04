//
//  ParkCheckpoint.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 04.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Types of park checkpoints
enum ParkCheckpointType {
    case areaEntrance
    case rideEntrance
    case kioskRegister
}

/// Blueprint for checkpoint at the park
protocol ParkCheckpoint {
    var checkPointType: ParkCheckpointType { get }
    func validate(pass: Pass) -> Bool
}
