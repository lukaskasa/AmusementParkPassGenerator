//
//  ViewController.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Park Areas
    var amusementArea = ParkAccessArea(area: .amusement)
    var kitchenArea = ParkAccessArea(area: .kitchen)
    var rideControlArea = ParkAccessArea(area: .rideControl)
    var maintenance = ParkAccessArea(area: .maintanance)
    var office = ParkAccessArea(area: .office)
    
    var parkLocations = [ParkAccessArea]()
    
    var rideTurnstile = RideTurnstile()
    var fastAccessLane = FastLaneRideTurnstile()
    
    var parkKioskRegister = ParkKioskRegister()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        parkLocations = [amusementArea, kitchenArea, rideControlArea, maintenance, office]
        
        // MARK: - Test cases
        
        /// Test Case - Classic Guest -> Swipe at each location, ride access and discount access
        
        //testClassicGuest()
        
        /// Test Case - Test Vip Guest -> Swipe at each location, ride access and discount access
        
        // testVipGuest()
        
        /// Test Case - Test Child Guest -> Swipe at each location, ride access and discount access
        
        // testChildGuest()
        
        /// Test Case - Child with no Date of Birth
        
        // testChildGuestErrorNoDOB()
        
        /// Test Case - Date of Birth is invalid
    
        /// testChildGuestErrorInvalidDOB()
        
        // Test Case - Child is too old
        
        // testChildGuestErrorChildtooOld()
        
        // Test Case - Birthday
        
        // testChildGuestBirthdayAlert(dateOfBirth: "05/05/2015")
        
        /// Test Case - Test Emplpoyees (Food- and Ride Service + Manager) -> Swipe at each location, ride access and discount access
        
        //testEmployees()
        
        /// Test Case - Employee with missing first name
        
        // testEmployeesErrorMissingInfo()
        
        /// Test Case - Vip Guest Swipes Pass twice within 5 seconds (two method calls within 5 seconds)
        
        // testVipGuestErroSwipesTwice()
        
    }
    
    func testClassicGuest() {
        // Test Cases - Classic Guest
        // Classic Guest
        let classicGuest = Guest(entrantType: .classic)
        // Pass
        let classicGuestPass = EntryPass(for: classicGuest)
        
        // Test Location Access
        testLocationAccess(pass: classicGuestPass)
        
        // Test Ride Access
        print("Ride Access: \(classicGuestPass.swipePass(at: rideTurnstile))")
        //print("Ride Access: \(classicGuestPass.swipePass(at: rideTurnstile))")
        //print("Skip all ride Lines: \(classicGuestPass.swipePass(at: fastAccessLane))")
        print("Discount Available: \(classicGuestPass.swipePass(at: parkKioskRegister))")
        if classicGuestPass.swipePass(at: parkKioskRegister) {
            print("Food Discount: \(classicGuestPass.entrant!.discountAccess[0].discountAmount)%")
            print("Merch Discount: \(classicGuestPass.entrant!.discountAccess[1].discountAmount)%")
        }
    }
    
    func testVipGuest() {
        // Test Cases - Vip Guest
        let vipGuest = Guest(entrantType: .vip)
        // Pass
        let vipGuestPass = EntryPass(for: vipGuest)
        
        // Test Location Access
        testLocationAccess(pass: vipGuestPass)
        
        // Test Ride Access
        //print("Ride Access: \(vipGuestPass.swipePass(at: rideTurnstile))")
        //print("Ride Access: \(vipGuestPass.swipePass(at: rideTurnstile))")
        print("Skip all ride Lines: \(vipGuestPass.swipePass(at: fastAccessLane))")
        print("Discount Available: \(vipGuestPass.swipePass(at: parkKioskRegister))")
        if vipGuestPass.swipePass(at: parkKioskRegister) {
            print("Food Discount: \(vipGuestPass.entrant!.discountAccess[0].discountAmount)%")
            print("Merch Discount: \(vipGuestPass.entrant!.discountAccess[1].discountAmount)%")
        }
    }
    
    func testVipGuestErroSwipesTwice() {
        // Test Cases - Vip Guest
        let vipGuest = Guest(entrantType: .vip)
        // Pass
        let vipGuestPass = EntryPass(for: vipGuest)
        
        // Test Ride Access
        print("Skip all ride Lines: \(vipGuestPass.swipePass(at: fastAccessLane))")
        print("Ride Access: \(vipGuestPass.swipePass(at: fastAccessLane))")
    }
    
    
    func testChildGuest() {
        // Test Cases - Child Guest
        do {
            let childGuest = try ChildGuest(dateOfBirth: "04/12/2015")
            let childGuestPass = EntryPass(for: childGuest)
            // Test Location Access
            testLocationAccess(pass: childGuestPass)
            // Test Ride Access
            print("Ride Access: \(childGuestPass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(childGuestPass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(childGuestPass.swipePass(at: fastAccessLane))")
            print("Discount Available: \(childGuestPass.swipePass(at: parkKioskRegister))")
            if childGuestPass.swipePass(at: parkKioskRegister) {
                print("Food Discount: \(childGuestPass.entrant!.discountAccess[0].discountAmount)%")
                print("Merch Discount: \(childGuestPass.entrant!.discountAccess[1].discountAmount)%")
            }
        } catch InvalidData.invalidDateOfBirth {
            print("Invalid Date of Birth!")
        } catch InvalidData.childIsTooOld {
            print("Child is too old!")
        } catch MissingData.missingDateOfBirth {
            print("Please provide a Date of Birth for the child!")
        } catch let error {
            fatalError("Error occured: \(error)")
        }
    }
    
    func testChildGuestErrorNoDOB() {
        // Test Cases - Child Guest
        do {
            let childGuest = try ChildGuest(dateOfBirth: "")
            let childGuestPass = EntryPass(for: childGuest)
            // Test Location Access
            testLocationAccess(pass: childGuestPass)
            // Test Ride Access
            print("Ride Access: \(childGuestPass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(childGuestPass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(childGuestPass.swipePass(at: fastAccessLane))")
            print("Discount Available: \(childGuestPass.swipePass(at: parkKioskRegister))")
            if childGuestPass.swipePass(at: parkKioskRegister) {
                print("Food Discount: \(childGuestPass.entrant!.discountAccess[0].discountAmount)%")
                print("Merch Discount: \(childGuestPass.entrant!.discountAccess[1].discountAmount)%")
            }
        } catch InvalidData.invalidDateOfBirth {
            print("Invalid Date of Birth!")
        } catch InvalidData.childIsTooOld {
            print("Child is too old!")
        } catch MissingData.missingDateOfBirth {
            print("Please provide a Date of Birth for the child!")
        } catch let error {
            fatalError("Error occured: \(error)")
        }
    }
    
    func testChildGuestErrorInvalidDOB() {
        // Test Cases - Child Guest
        do {
            let childGuest = try ChildGuest(dateOfBirth: "32/11/11")
            let childGuestPass = EntryPass(for: childGuest)
            // Test Location Access
            testLocationAccess(pass: childGuestPass)
            // Test Ride Access
            print("Ride Access: \(childGuestPass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(childGuestPass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(childGuestPass.swipePass(at: fastAccessLane))")
            print("Discount Available: \(childGuestPass.swipePass(at: parkKioskRegister))")
            if childGuestPass.swipePass(at: parkKioskRegister) {
                print("Food Discount: \(childGuestPass.entrant!.discountAccess[0].discountAmount)%")
                print("Merch Discount: \(childGuestPass.entrant!.discountAccess[1].discountAmount)%")
            }
        } catch InvalidData.invalidDateOfBirth {
            print("Invalid Date of Birth!")
        } catch InvalidData.childIsTooOld {
            print("Child is too old!")
        } catch MissingData.missingDateOfBirth {
            print("Please provide a Date of Birth for the child!")
        } catch let error {
            fatalError("Error occured: \(error)")
        }
    }
    
    func testChildGuestErrorChildtooOld() {
        // Test Cases - Child Guest
        do {
            // Format - MM/DD/YYYY
            let childGuest = try ChildGuest(dateOfBirth: "04/11/2005")
            let childGuestPass = EntryPass(for: childGuest)
            // Test Location Access
            testLocationAccess(pass: childGuestPass)
            // Test Ride Access
            print("Ride Access: \(childGuestPass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(childGuestPass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(childGuestPass.swipePass(at: fastAccessLane))")
            print("Discount Available: \(childGuestPass.swipePass(at: parkKioskRegister))")
            if childGuestPass.swipePass(at: parkKioskRegister) {
                print("Food Discount: \(childGuestPass.entrant!.discountAccess[0].discountAmount)%")
                print("Merch Discount: \(childGuestPass.entrant!.discountAccess[1].discountAmount)%")
            }
        } catch InvalidData.invalidDateOfBirth {
            print("Invalid Date of Birth!")
        } catch InvalidData.childIsTooOld {
            print("Child is too old!")
        } catch MissingData.missingDateOfBirth {
            print("Please provide a Date of Birth for the child!")
        } catch let error {
            fatalError("Error occured: \(error)")
        }
    }
    
    func testChildGuestBirthdayAlert(dateOfBirth: String) {
        // Test Cases - Child Guest
        do {
            // Format - MM/DD/YYYY
            let childGuest = try ChildGuest(dateOfBirth: dateOfBirth)
            let childGuestPass = EntryPass(for: childGuest)
            
            // Test Ride Access
            print("Ride Access: \(childGuestPass.swipePass(at: rideTurnstile))")

        } catch InvalidData.invalidDateOfBirth {
            print("Invalid Date of Birth!")
        } catch InvalidData.childIsTooOld {
            print("Child is too old!")
        } catch MissingData.missingDateOfBirth {
            print("Please provide a Date of Birth for the child!")
        } catch let error {
            fatalError("Error occured: \(error)")
        }
    }
    
    func testEmployees() {
        do {
            // Test Cases - Employee - Food
            let foodEmployee = try Employee(entrantType: .foodService, firstName: "Lukas", lastName: "Kasakaitis", streetAddress: "1 Main Street", city: "Munich", state: "Bavaria", zipCode: "81669")
            let foodEmployeePass = EntryPass(for: foodEmployee)
            testLocationAccess(pass: foodEmployeePass)
            // Test Ride Access
            print("Ride Access: \(foodEmployeePass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(foodEmployeePass.swipePass(at: rideTurnstile))")
            //print("Skip all ride Lines: \(foodEmployeePass.swipePass(at: fastAccessLane))")
            print("Discount Available: \(foodEmployeePass.swipePass(at: parkKioskRegister))")
            if foodEmployeePass.swipePass(at: parkKioskRegister) {
                print("Food Discount: \(foodEmployeePass.entrant!.discountAccess[0].discountAmount)%")
                print("Merch Discount: \(foodEmployeePass.entrant!.discountAccess[1].discountAmount)%")
            }
            // Test Cases - Employee - Ride
            let rideEmployee = try Employee(entrantType: .rideService, firstName: "Lukas", lastName: "Kasakaitis", streetAddress: "1 Main Street", city: "Munich", state: "Bavaria", zipCode: "81669")
            let rideEmployeePass = EntryPass(for: rideEmployee)
            testLocationAccess(pass: rideEmployeePass)
            // Test Ride Access
            print("Ride Access: \(rideEmployeePass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(rideEmployeePass.swipePass(at: rideTurnstile))")
            //print("Skip all ride Lines: \(rideEmployeePass.swipePass(at: fastAccessLane))")
            if rideEmployeePass.swipePass(at: parkKioskRegister) {
                print("Food Discount: \(rideEmployeePass.entrant!.discountAccess[0].discountAmount)%")
                print("Merch Discount: \(rideEmployeePass.entrant!.discountAccess[1].discountAmount)%")
            }
            // Test Cases - Employee - Maintenance
            let maintenanceEmployee = try Employee(entrantType: .maintenance, firstName: "Lukas", lastName: "Kasakaitis", streetAddress: "1 Main Street", city: "Munich", state: "Bavaria", zipCode: "81669")
            let maintenanceEmployeePass = EntryPass(for: maintenanceEmployee)
            testLocationAccess(pass: maintenanceEmployeePass)
            // Test Ride Access
            print("Ride Access: \(maintenanceEmployeePass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(maintenanceEmployeePass.swipePass(at: rideTurnstile))")
            //print("Skip all ride Lines: \(maintenanceEmployeePass.swipePass(at: fastAccessLane))")
            if maintenanceEmployeePass.swipePass(at: parkKioskRegister) {
                print("Food Discount: \(maintenanceEmployeePass.entrant!.discountAccess[0].discountAmount)%")
                print("Merch Discount: \(maintenanceEmployeePass.entrant!.discountAccess[1].discountAmount)%")
            }
            // Test Cases - Employee - Manager
            let manager = try Employee(entrantType: .manager, firstName: "Lukas", lastName: "Kasakaitis", streetAddress: "1 Main Street", city: "Munich", state: "Bavaria", zipCode: "81669")
            let managerPass = EntryPass(for: manager)
            // Test Ride Access
            testLocationAccess(pass: managerPass)
            print("Ride Access: \(managerPass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(managerPass.swipePass(at: rideTurnstile))")
            //print("Skip all ride Lines: \(managerPass.swipePass(at: fastAccessLane))")
            if managerPass.swipePass(at: parkKioskRegister) {
                print("Food Discount: \(managerPass.entrant!.discountAccess[0].discountAmount)%")
                print("Merch Discount: \(managerPass.entrant!.discountAccess[1].discountAmount)%")
            }
        } catch MissingData.missingFirstName {
            print(MissingData.missingFirstName.rawValue)
        } catch MissingData.missingLastName {
            print(MissingData.missingLastName.rawValue)
        } catch MissingData.missingStreetAddress {
            print(MissingData.missingStreetAddress.rawValue)
        } catch MissingData.missingCity {
            print(MissingData.missingCity.rawValue)
        } catch MissingData.missingState {
            print(MissingData.missingState.rawValue)
        } catch MissingData.missingZipCode {
            print(MissingData.missingZipCode.rawValue)
        } catch let error {
            fatalError("Error occured: \(error)")
        }

    }
    
    func testEmployeesErrorMissingInfo() {
        do {
            // Test Cases - Employee - Food
            let foodEmployee = try Employee(entrantType: .foodService, firstName: "", lastName: "Kasakaitis", streetAddress: "1 Main Street", city: "Munich", state: "Bavaria", zipCode: "81669")
            let foodEmployeePass = EntryPass(for: foodEmployee)
            testLocationAccess(pass: foodEmployeePass)
            // Test Ride Access
            print("Ride Access: \(foodEmployeePass.swipePass(at: rideTurnstile))")
            //print("Ride Access: \(foodEmployeePass.swipePass(at: rideTurnstile))")
            //print("Skip all ride Lines: \(foodEmployeePass.swipePass(at: fastAccessLane))")
            print("Discount Available: \(foodEmployeePass.swipePass(at: parkKioskRegister))")
            if foodEmployeePass.swipePass(at: parkKioskRegister) {
                print("Food Discount: \(foodEmployeePass.entrant!.discountAccess[0].discountAmount)%")
                print("Merch Discount: \(foodEmployeePass.entrant!.discountAccess[1].discountAmount)%")
            }
        } catch MissingData.missingFirstName {
            print(MissingData.missingFirstName.rawValue)
        } catch MissingData.missingLastName {
            print(MissingData.missingLastName.rawValue)
        } catch MissingData.missingStreetAddress {
            print(MissingData.missingStreetAddress.rawValue)
        } catch MissingData.missingCity {
            print(MissingData.missingCity.rawValue)
        } catch MissingData.missingState {
            print(MissingData.missingState.rawValue)
        } catch MissingData.missingZipCode {
            print(MissingData.missingZipCode.rawValue)
        } catch let error {
            fatalError("Error occured: \(error)")
        }
        
    }
    
    func testLocationAccess(pass: EntryPass) {
        print("\(pass.entrant!.entrantType)")
        for location in parkLocations {
            print("Access to '\(location.area.rawValue)':  \(pass.swipePass(at: location))")
        }
    }
    
}

