//
//  Entrant.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 20.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation

class Entrant: Generatable {
    
    var entrantType: EntrantType
    
    init(entrantType: EntrantType) {
        self.entrantType = entrantType
    }
    
    func generatePass() throws -> Pass {
        return ClassicPass(entrantType: GuestType.classic, firstName: nil, lastName: nil, dateOfBirth: nil)
    }

}
