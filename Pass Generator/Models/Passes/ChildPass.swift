//
//  ChildPass.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 26.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class ChildPass: ClassicPass {
    
    init(entrantType: EntrantType, firstName: String?, lastName: String?, dateOfBirth: Date) {
        super.init(entrantType: entrantType, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth)
    }
    
}
