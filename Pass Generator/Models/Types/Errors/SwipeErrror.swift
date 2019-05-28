//
//  SwipeErrror.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 04.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

/// Type for a swipe error
enum SwipeError: String, Error {
    case swipedTooOften = "Please wait 5 seconds before swiping again, thank your for you patience!"
}
