//
//  String.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 18.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

extension String {
    
    
    /**
     Converts a String into a Date given the correct format MM/dd/yyyy
     
     - Throws: 'InvalidData.invalidDateOfBirth'- if date provided is not valid.
     
     - Returns: Date of birth as a Date type
     */
    func convertToDate() throws -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let dateOfBirth = formatter.date(from: self) else { throw InvalidData.invalidDateOfBirth }
        return dateOfBirth
    }
    
}
