//
//  ViewController.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pass: Pass?
    
    let classicGuest = Guest(entrantType: .classic, dateOfBirth: nil)
    let vipGuest = Guest(entrantType: .vip, dateOfBirth: nil)
    let childGuest = Guest(entrantType: .child, dateOfBirth: "04/28/2015")
    let chef = Employee(entrantType: .foodService, firstName: "George", lastName: "Washington", streetAddress: "White House", city: "Washington", state: "District Columbia", zipCode: "20001")
    let rideManager = Employee(entrantType: .rideService, firstName: "Will", lastName: "Smith", streetAddress: "1 Main Street", city: "Los Angeles", state: "CA", zipCode: "810101")
    let maintenance = Employee(entrantType: .maintenance, firstName: "Michael", lastName: "Jordan", streetAddress: "1 Park Avenue", city: "New York City", state: "New York", zipCode: "93213")
    let manager = Employee(entrantType: .manager, firstName: "Donald", lastName: "Trump", streetAddress: "White House", city: "Washington", state: "District Columbia", zipCode: "20001")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            self.pass = try manager.generatePass()
        }  catch MissingData.missingFirstName {
            print(MissingData.missingFirstName.rawValue)
        } catch MissingData.missingLastName {
            print(MissingData.missingLastName.rawValue)
        } catch MissingData.missingStreetAddress {
            print(MissingData.missingStreetAddress.rawValue)
        } catch let error {
            fatalError("Error: \(error)")
        }
        
        do {
            print("Food discount: \(try pass?.discountAccess(type: .foodDiscount))")
            print("Merchandise discount: \(try pass?.discountAccess(type: .merchandiseDiscount))")
        } catch SwipeError.swipedTooOften {
            
        } catch let error {
            fatalError("Error: \(error)")
        }
        
        do {
            print("Ride Access: \(try pass?.hasRideAccess())")
        } catch SwipeError.swipedTooOften {
            print ("5s Swipe Delay")
        } catch let error {
            fatalError("Error: \(error)")
        }
        
        do {
            print("Amusement Park: \(try pass?.validateAreaAccess(area: .amusement))")
            print("Kitchen: \(try pass?.validateAreaAccess(area: .kitchen))")
            print("Ride Control: \(try pass?.validateAreaAccess(area: .rideControl))")
            print("Maintenance: \(try pass?.validateAreaAccess(area: .maintanance))")
            print("Office: \(try pass?.validateAreaAccess(area: .office))")
        } catch SwipeError.swipedTooOften {
            print ("5s Swipe Delay")
        } catch let error {
            fatalError("Error: \(error)")
        }
    }
    
}

