//
//  DataGenerator.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 26.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation
import GameKit

// Struct to retrieve random data for the fields
struct DataGenerator {
    
    let childAgeLimit = 5
    let seniorAge = 60.0
    let zipCodeUpperBound = 90000
    let zipCodeLowerBound = 10000
    let calendar  = Calendar(identifier: .gregorian)
    
    let firstNames = [ "Oliver", "Jack", "Harry", "Jacob", "Charlie", "Thomas", "George", "Oscar", "James", "William", "Amelia", "Olivia", "Isla", "Emily", "Poppy", "Ava", "Isabella", "Jessica", "Lily", "Sophie" ]
    let lastNames = [ "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson" ]
    let streetAddresses = [ "King's Road 1", "Abbey Road 2", "Carnaby Street 3", "Portobello Road 4", "Downing Street 5", "Downing Street 6", "Shaftesbury Avenue 7", "The Strand 8", "Broadway 9", "Bowery 10", "Houston Street 11", "Canal Street 12", "Avenue of the Americas 13", "Madison, Park and Lexington Avenues 14", "Maiden Lane 15", "Christopher Street 16", "Steinway Street 17", "Utopia Parkway 18", "Love Lane 19", "Victory Boulevard 20" ]
    let cities = [ "New York City", "Los Angeles", "Mexico City", "Orlando", "Chicago", "Houston", "Philadelphia", "Boston", "Detroit", "Denver", "Dallas", "San Fransciso", "Palo Alto", "Mointain View", "Las Vegas", "San Diego", "Miami", "Atlanta", "Nashville" ]
    let states = [ "Florida", "California", "Texas", "Washington", "New Jersey", "Arizona", "North Carolina", "Kansas", "Utah", "New Mexico", "New York", "North Dakota", "South Carolina", "Alaska", "Pennsylvania", "Montana", "Colorado", "Georgia", "Oklahoma", "Iowa" ]
    
    let projectNumbers = [ 1001, 1002, 1003, 2001, 2002 ]
    
    let companyNames = [ VendorCompany.acme:"Acme Corporation", VendorCompany.orkin:"Orkin, LLC", VendorCompany.fedex:"Fedex", VendorCompany.nwElectrical:"NW Electrical" ]
    
    var childDateOfBirth: String {
        let day = GKRandomSource.sharedRandom().nextInt(upperBound: childAgeLimit*365)
        var offsetComponents = DateComponents()
        offsetComponents.day = -1 * Int(day - 1)
        guard let date = calendar.date(byAdding: offsetComponents, to: Date()) else { fatalError() }
        return "\(calendar.component(.month, from: date))/\(calendar.component(.day, from: date))/\(calendar.component(.year, from: date))"
    }
    
    var seniorDateOfBirth: String {
        let day = GKRandomSource.sharedRandom().nextInt(upperBound: Int(seniorAge*365))
        var offsetComponents = DateComponents()
        offsetComponents.day = -1 * Int(day - 1)
        guard let date = calendar.date(byAdding: offsetComponents, to: Date(timeIntervalSinceNow: -seniorAge*365.25*24*60*60)) else { fatalError() }
        return "\(calendar.component(.month, from: date))/\(calendar.component(.day, from: date))/\(calendar.component(.year, from: date))"
    }
    
    var projectNumber: String {
        return "\(projectNumbers[GKRandomSource.sharedRandom().nextInt(upperBound: projectNumbers.count)])"
    }
    
    var firstName: String {
        return firstNames[GKRandomSource.sharedRandom().nextInt(upperBound: firstNames.count)]
    }
    
    var lastName: String {
        return lastNames[GKRandomSource.sharedRandom().nextInt(upperBound: lastNames.count)]
    }
    
    var streetAddress: String {
       return streetAddresses[GKRandomSource.sharedRandom().nextInt(upperBound: streetAddresses.count)]
    }
    
    var city: String {
        return cities[GKRandomSource.sharedRandom().nextInt(upperBound: cities.count)]
    }
    
    var state: String {
        return states[GKRandomSource.sharedRandom().nextInt(upperBound: states.count)]
    }
    
    var zipCode: String {
        let upperBound = GKRandomSource.sharedRandom().nextInt(upperBound: zipCodeUpperBound)
        return "\(upperBound + zipCodeLowerBound)"
    }
    
    func getData(for field: FormField, senior: Bool = false, company: VendorCompany = .acme) -> String {
        switch field {
        case .dateOfBirthField:
            if senior {
                return seniorDateOfBirth
            }
            return childDateOfBirth
        case .projectNumberField:
            return projectNumber
        case .firstNameField:
            return firstName
        case .lastNameField:
            return lastName
        case .companyField:
            guard let companyName = companyNames[company] else { fatalError() }
            return companyName
        case .streetAddressField:
            return streetAddress
        case .cityField:
            return city
        case .stateField:
            return state
        case .zipCodeField:
            return zipCode
        case .ssnField:
            return "111-11-1111"
        }
    }
    
}
