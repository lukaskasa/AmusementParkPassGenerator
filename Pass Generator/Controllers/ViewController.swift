//
//  ViewController.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let guest = Guest(entrantType: .child, dateOfBirth: "04/15/2015")
    let employee = Employee(entrantType: .manager, firstName: "Lukas", lastName: "Kasakaitis", streetAddress: "Goo str. 1", city: "Munich", state: "Bavaria", zipCode: "80335")
    
    let generator = PassGenerator()
    let validator = PassValidator()
    
    var employeePass: Pass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        employeePass = generator.generatePass(for: employee)
        do {
            print(try validator.validate(.rideAccess, with: employeePass!))
        } catch {
            
        }
    }
    
}

