//
//  ViewController.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 10.04.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import UIKit

// Enum to identify entrant type buttons
enum EntrantTypeButton: Int {
    case guestButton = 1
    case employeeButton = 2
    case managerButton = 3
    case vendorButton = 4
}

// Enum to identify input fields
enum FormField: Int {
    case dateOfBirthField = 1
    case ssnField = 2
    case projectNumberField = 3
    case firstNameField = 4
    case lastNameField = 5
    case companyField = 6
    case streetAddressField = 7
    case cityField = 8
    case stateField = 9
    case zipCodeField = 10
}

class ViewController: UIViewController {
    
    var keyboardHeight: CGFloat = 0
    let typeButtonFontSize: CGFloat = 20.0
    let subTypeButtonFontSize: CGFloat = 16.0
    let dataGenerator = DataGenerator()
    var entrantPass: EntryPass?
    var selectedType: EntrantType = GuestType.child
    
    
    // MARK: - Property Outlets
    
    @IBOutlet var entrantTypeButtons: [UIButton]!
    @IBOutlet var entrantSubTypeButtons: [UIButton]!
    @IBOutlet var formFields: [UITextField]!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet var topStackViewConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up
        setUpNotifications(for: [.streetAddressField, .cityField, .stateField, .zipCodeField])
        disableFields()
        toggleForm(for: selectedType)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        clearForm()
    }
    
    // MARK: - Prepare Segue
    
    /**
     Called when a segue is about to be performed.
     
     - Parameters:
     - segue: The segue object containing information about the view controllers involved in the segue.
     - sender: The object that initiated the segue. You might use this parameter to perform different actions based on which control (or other object) initiated the segue.
     
     - Returns: Void
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPass" {
            let passViewController = segue.destination as! PassViewController
            if let entrantPass = entrantPass {
                passViewController.entrantPass = entrantPass
            }
        }
    }
    
    // MARK: - Action Methods

    @IBAction func switchEntrantType(_ sender: UIButton) {
        clearForm()
        hideButtons(entrantSubTypeButtons)
        setTitleWeight(target: sender, buttonRow: entrantTypeButtons, fontSize: typeButtonFontSize)
        setTitleWeight(target: entrantSubTypeButtons[0], buttonRow: entrantSubTypeButtons, fontSize: subTypeButtonFontSize)
        
        switch sender.tag {
        case EntrantTypeButton.guestButton.rawValue:
            showButtons(entrantSubTypeButtons, for: GuestType.allCases)
            selectedType = GuestType.child
            toggleForm(for: selectedType)
        case EntrantTypeButton.employeeButton.rawValue:
            showButtons(entrantSubTypeButtons, for: EmployeeType.allCases.filter({ $0 != .manager }))
            selectedType = EmployeeType.foodService
            toggleForm(for: selectedType)
        case EntrantTypeButton.managerButton.rawValue:
            selectedType = EmployeeType.manager
            toggleForm(for: selectedType)
        case EntrantTypeButton.vendorButton.rawValue:
            showButtons(entrantSubTypeButtons, for: VendorCompany.allCases)
            selectedType = VendorCompany.acme
            toggleForm(for: selectedType)
        default:
            return
        }
        
    }
    
    @IBAction func switchEntrantTypeForm(_ sender: UIButton) {
        clearForm()
        disableFields()
        guard let currentTitle = sender.currentTitle else { return }
        setTitleWeight(target: sender, buttonRow: entrantSubTypeButtons, fontSize: subTypeButtonFontSize)
        selectType(currentTitle)
        toggleForm(for: selectedType)
    }
    
    @IBAction func generatePass(_ sender: UIButton) {
        switch selectedType  {
        case GuestType.classic:
            entrantPass = EntryPass(for: Guest(entrantType: .classic))
        case GuestType.vip:
            entrantPass = EntryPass(for: Guest(entrantType: .vip))
        case GuestType.child:
            do {
                let child = try ChildGuest(dateOfBirth: getInfo(from: .dateOfBirthField))
                entrantPass = EntryPass(for: child)
            } catch MissingData.missingDateOfBirth {
                showAlertWith(title: "Missing info", message: MissingData.missingDateOfBirth.rawValue)
            } catch InvalidData.childIsTooOld {
                showAlertWith(title: "Too old", message: InvalidData.childIsTooOld.rawValue)
            } catch InvalidData.invalidDateOfBirth {
                showAlertWith(title: "Invalid", message: InvalidData.invalidDateOfBirth.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case GuestType.seasonPassHolder:
            do {
                let seasonPassHolder = try SeasonPassGuest(firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), streetAddress: getInfo(from: .streetAddressField), city: getInfo(from: .cityField)!, state: getInfo(from: .stateField), zipCode: getInfo(from: .zipCodeField))
                entrantPass = EntryPass(for: seasonPassHolder)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch MissingData.missingStreetAddress {
                showAlertWith(title: "Missing Street Address", message: MissingData.missingStreetAddress.rawValue)
            } catch MissingData.missingCity {
                showAlertWith(title: "Missing City", message: MissingData.missingCity.rawValue)
            } catch MissingData.missingState {
                showAlertWith(title: "Missing State", message: MissingData.missingState.rawValue)
            } catch MissingData.missingZipCode {
                showAlertWith(title: "Missing Zip Code", message: MissingData.missingZipCode.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidStreetAddress {
                showAlertWith(title: "Invalid Street Address", message: InvalidData.invalidStreetAddress.rawValue)
            } catch InvalidData.invalidCity {
                showAlertWith(title: "Invalid City", message: InvalidData.invalidCity.rawValue)
            } catch InvalidData.invalidState {
                showAlertWith(title: "Invalid State", message: InvalidData.invalidState.rawValue)
            } catch InvalidData.invalidZipCode {
                showAlertWith(title: "Invalid Zip Code", message: InvalidData.invalidZipCode.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case GuestType.senior:
            do {
                let seasonPassHolder = try SeniorGuest(firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), dateOfBirth: getInfo(from: .dateOfBirthField))
                entrantPass = EntryPass(for: seasonPassHolder)
            } catch MissingData.missingDateOfBirth {
                showAlertWith(title: "Missing Date of Birth", message: MissingData.missingDateOfBirth.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidDateOfBirth {
                showAlertWith(title: "Date of Birth is not valid!", message: InvalidData.invalidDateOfBirth.rawValue)
            } catch InvalidData.isNotSenior {
                showAlertWith(title: "Is not a senior", message: InvalidData.isNotSenior.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case EmployeeType.foodService:
            do {
                let employee = try Employee(entrantType: .foodService, firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), streetAddress: getInfo(from: .streetAddressField), city: getInfo(from: .cityField), state: getInfo(from: .stateField), zipCode: getInfo(from: .zipCodeField))
                entrantPass = EntryPass(for: employee)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch MissingData.missingStreetAddress {
                showAlertWith(title: "Missing Street Address", message: MissingData.missingStreetAddress.rawValue)
            } catch MissingData.missingCity {
                showAlertWith(title: "Missing City", message: MissingData.missingCity.rawValue)
            } catch MissingData.missingState {
                showAlertWith(title: "Missing State", message: MissingData.missingState.rawValue)
            } catch MissingData.missingZipCode {
                showAlertWith(title: "Missing Zip Code", message: MissingData.missingZipCode.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidStreetAddress {
                showAlertWith(title: "Invalid Street Address", message: InvalidData.invalidStreetAddress.rawValue)
            } catch InvalidData.invalidCity {
                showAlertWith(title: "Invalid City", message: InvalidData.invalidCity.rawValue)
            } catch InvalidData.invalidState {
                showAlertWith(title: "Invalid State", message: InvalidData.invalidState.rawValue)
            } catch InvalidData.invalidZipCode {
                showAlertWith(title: "Invalid Zip Code", message: InvalidData.invalidZipCode.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case EmployeeType.rideService:
            do {
                let employee = try Employee(entrantType: .rideService, firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), streetAddress: getInfo(from: .streetAddressField), city: getInfo(from: .cityField), state: getInfo(from: .stateField), zipCode: getInfo(from: .zipCodeField))
                entrantPass = EntryPass(for: employee)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch MissingData.missingStreetAddress {
                showAlertWith(title: "Missing Street Address", message: MissingData.missingStreetAddress.rawValue)
            } catch MissingData.missingCity {
                showAlertWith(title: "Missing City", message: MissingData.missingCity.rawValue)
            } catch MissingData.missingState {
                showAlertWith(title: "Missing State", message: MissingData.missingState.rawValue)
            } catch MissingData.missingZipCode {
                showAlertWith(title: "Missing Zip Code", message: MissingData.missingZipCode.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidStreetAddress {
                showAlertWith(title: "Invalid Street Address", message: InvalidData.invalidStreetAddress.rawValue)
            } catch InvalidData.invalidCity {
                showAlertWith(title: "Invalid City", message: InvalidData.invalidCity.rawValue)
            } catch InvalidData.invalidState {
                showAlertWith(title: "Invalid State", message: InvalidData.invalidState.rawValue)
            } catch InvalidData.invalidZipCode {
                showAlertWith(title: "Invalid Zip Code", message: InvalidData.invalidZipCode.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case EmployeeType.maintenance:
            do {
                let employee = try Employee(entrantType: .maintenance, firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), streetAddress: getInfo(from: .streetAddressField), city: getInfo(from: .cityField), state: getInfo(from: .stateField), zipCode: getInfo(from: .zipCodeField))
                entrantPass = EntryPass(for: employee)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch MissingData.missingStreetAddress {
                showAlertWith(title: "Missing Street Address", message: MissingData.missingStreetAddress.rawValue)
            } catch MissingData.missingCity {
                showAlertWith(title: "Missing City", message: MissingData.missingCity.rawValue)
            } catch MissingData.missingState {
                showAlertWith(title: "Missing State", message: MissingData.missingState.rawValue)
            } catch MissingData.missingZipCode {
                showAlertWith(title: "Missing Zip Code", message: MissingData.missingZipCode.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidStreetAddress {
                showAlertWith(title: "Invalid Street Address", message: InvalidData.invalidStreetAddress.rawValue)
            } catch InvalidData.invalidCity {
                showAlertWith(title: "Invalid City", message: InvalidData.invalidCity.rawValue)
            } catch InvalidData.invalidState {
                showAlertWith(title: "Invalid State", message: InvalidData.invalidState.rawValue)
            } catch InvalidData.invalidZipCode {
                showAlertWith(title: "Invalid Zip Code", message: InvalidData.invalidZipCode.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case EmployeeType.contractor:
            do {
                let contractorEmployee = try ContractEmployee(firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), streetAddress: getInfo(from: .streetAddressField), city: getInfo(from: .cityField), state: getInfo(from: .stateField), zipCode: getInfo(from: .zipCodeField), projectNumber: getInfo(from: .projectNumberField))
                entrantPass = EntryPass(for: contractorEmployee)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch MissingData.missingStreetAddress {
                showAlertWith(title: "Missing Street Address", message: MissingData.missingStreetAddress.rawValue)
            } catch MissingData.missingCity {
                showAlertWith(title: "Missing City", message: MissingData.missingCity.rawValue)
            } catch MissingData.missingState {
                showAlertWith(title: "Missing State", message: MissingData.missingState.rawValue)
            } catch MissingData.missingZipCode {
                showAlertWith(title: "Missing Zip Code", message: MissingData.missingZipCode.rawValue)
            } catch MissingData.missingProjectNumber {
                showAlertWith(title: "Missing Project Number", message: MissingData.missingProjectNumber.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidStreetAddress {
                showAlertWith(title: "Invalid Street Address", message: InvalidData.invalidStreetAddress.rawValue)
            } catch InvalidData.invalidCity {
                showAlertWith(title: "Invalid City", message: InvalidData.invalidCity.rawValue)
            } catch InvalidData.invalidState {
                showAlertWith(title: "Invalid State", message: InvalidData.invalidState.rawValue)
            } catch InvalidData.invalidZipCode {
                showAlertWith(title: "Invalid Zip Code", message: InvalidData.invalidZipCode.rawValue)
            } catch InvalidData.invalidProjectNumber {
                showAlertWith(title: "Invalid Project Number", message: InvalidData.invalidProjectNumber.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case EmployeeType.manager:
            do {
                let employee = try Employee(entrantType: .manager, firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), streetAddress: getInfo(from: .streetAddressField), city: getInfo(from: .cityField), state: getInfo(from: .stateField), zipCode: getInfo(from: .zipCodeField))
                entrantPass = EntryPass(for: employee)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch MissingData.missingStreetAddress {
                showAlertWith(title: "Missing Street Address", message: MissingData.missingStreetAddress.rawValue)
            } catch MissingData.missingCity {
                showAlertWith(title: "Missing City", message: MissingData.missingCity.rawValue)
            } catch MissingData.missingState {
                showAlertWith(title: "Missing State", message: MissingData.missingState.rawValue)
            } catch MissingData.missingZipCode {
                showAlertWith(title: "Missing Zip Code", message: MissingData.missingZipCode.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidStreetAddress {
                showAlertWith(title: "Invalid Street Address", message: InvalidData.invalidStreetAddress.rawValue)
            } catch InvalidData.invalidCity {
                showAlertWith(title: "Invalid City", message: InvalidData.invalidCity.rawValue)
            } catch InvalidData.invalidState {
                showAlertWith(title: "Invalid State", message: InvalidData.invalidState.rawValue)
            } catch InvalidData.invalidZipCode {
                showAlertWith(title: "Invalid Zip Code", message: InvalidData.invalidZipCode.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case VendorCompany.acme:
            do {
                let vendor = try Vendor(entrantType: .acme, firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), dateOfBirth: getInfo(from: .dateOfBirthField), companyName: getInfo(from: .companyField))
                entrantPass = EntryPass(for: vendor)
            } catch MissingData.missingDateOfBirth {
                showAlertWith(title: "Missing Date of Birth", message: MissingData.missingDateOfBirth.rawValue)
            } catch MissingData.missingCompanyName {
                showAlertWith(title: "Missing Company Name", message: MissingData.missingCompanyName.rawValue)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidDateOfBirth {
                showAlertWith(title: "Date of Birth is not valid!", message: InvalidData.invalidDateOfBirth.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case VendorCompany.orkin:
            do {
                let vendor = try Vendor(entrantType: .orkin, firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), dateOfBirth: getInfo(from: .dateOfBirthField), companyName: getInfo(from: .companyField))
                entrantPass = EntryPass(for: vendor)
            } catch MissingData.missingDateOfBirth {
                showAlertWith(title: "Missing Date of Birth", message: MissingData.missingDateOfBirth.rawValue)
            } catch MissingData.missingCompanyName {
                showAlertWith(title: "Missing Company Name", message: MissingData.missingCompanyName.rawValue)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidDateOfBirth {
                showAlertWith(title: "Date of Birth is not valid!", message: InvalidData.invalidDateOfBirth.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case VendorCompany.fedex:
            do {
                let vendor = try Vendor(entrantType: .fedex, firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), dateOfBirth: getInfo(from: .dateOfBirthField), companyName: getInfo(from: .companyField))
                entrantPass = EntryPass(for: vendor)
            } catch MissingData.missingDateOfBirth {
                showAlertWith(title: "Missing Date of Birth", message: MissingData.missingDateOfBirth.rawValue)
            } catch MissingData.missingCompanyName {
                showAlertWith(title: "Missing Company Name", message: MissingData.missingCompanyName.rawValue)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidDateOfBirth {
                showAlertWith(title: "Date of Birth is not valid!", message: InvalidData.invalidDateOfBirth.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        case VendorCompany.nwElectrical:
            do {
                let vendor = try Vendor(entrantType: .nwElectrical, firstName: getInfo(from: .firstNameField), lastName: getInfo(from: .lastNameField), dateOfBirth: getInfo(from: .dateOfBirthField), companyName: getInfo(from: .companyField))
                entrantPass = EntryPass(for: vendor)
            } catch MissingData.missingDateOfBirth {
                showAlertWith(title: "Missing Date of Birth", message: MissingData.missingDateOfBirth.rawValue)
            } catch MissingData.missingCompanyName {
                showAlertWith(title: "Missing Company Name", message: MissingData.missingCompanyName.rawValue)
            } catch MissingData.missingFirstName {
                showAlertWith(title: "Missing First Name", message: MissingData.missingFirstName.rawValue)
            } catch MissingData.missingLastName {
                showAlertWith(title: "Missing Last Name", message: MissingData.missingLastName.rawValue)
            } catch InvalidData.invalidfirstName {
                showAlertWith(title: "Invalid First Name", message: InvalidData.invalidfirstName.rawValue)
            } catch InvalidData.invalidLastName {
                showAlertWith(title: "Invalid Last Name", message: InvalidData.invalidLastName.rawValue)
            } catch InvalidData.invalidDateOfBirth {
                showAlertWith(title: "Date of Birth is not valid!", message: InvalidData.invalidDateOfBirth.rawValue)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        default:
            return
        }
    }
    
    @IBAction func populateData(_ sender: UIButton) {
        switch selectedType {
        case GuestType.child:
            fillForm(for: [.dateOfBirthField])
        case GuestType.senior:
            fillForm(for: [.dateOfBirthField, .firstNameField, .lastNameField], senior: true)
        case GuestType.seasonPassHolder, EmployeeType.foodService, EmployeeType.rideService, EmployeeType.maintenance, EmployeeType.manager:
            fillForm(for: [.firstNameField, .lastNameField, .streetAddressField, .cityField, .stateField, .zipCodeField])
        case EmployeeType.contractor:
            fillForm(for: [.projectNumberField, .firstNameField, .lastNameField, .streetAddressField, .cityField, .stateField, .zipCodeField])
        case VendorCompany.acme:
            fillForm(for: [.dateOfBirthField, .firstNameField, .lastNameField, .companyField], senior: true, company: .acme)
        case VendorCompany.orkin:
            fillForm(for: [.dateOfBirthField, .firstNameField, .lastNameField, .companyField], senior: true, company: .orkin)
        case VendorCompany.fedex:
            fillForm(for: [.dateOfBirthField, .firstNameField, .lastNameField, .companyField], senior: true, company: .fedex)
        case VendorCompany.nwElectrical:
            fillForm(for: [.dateOfBirthField, .firstNameField, .lastNameField, .companyField], senior: true, company: .nwElectrical)
        default:
            return
        }
    }
    
    
    // MARK: - Helper Methods
    
    func fillForm(for fields: [FormField], senior: Bool = false, company: VendorCompany = .acme){
        for field in fields {
            formFields.filter({ $0.tag == field.rawValue }).first?.text = dataGenerator.getData(for: field, senior: senior, company: company)
        }
    }
    
    func clearForm() {
        for field in formFields {
            field.text = ""
        }
    }
    
    // Select Type
    func selectType(_ type: String) {
        switch type {
        case "Child":
            selectedType = GuestType.child
        case "Adult":
            selectedType = GuestType.classic
        case "VIP":
            selectedType = GuestType.vip
        case "Senior":
            selectedType = GuestType.senior
        case "Season":
            selectedType = GuestType.seasonPassHolder
        case "Food":
            selectedType = EmployeeType.foodService
        case "Ride":
            selectedType = EmployeeType.rideService
        case "Maintenance":
            selectedType = EmployeeType.maintenance
        case "Contractor":
            selectedType = EmployeeType.contractor
        case "Manager":
            selectedType = EmployeeType.manager
        case "Acme":
            selectedType = VendorCompany.acme
        case "Orkin":
            selectedType = VendorCompany.orkin
        case "Fedex":
            selectedType = VendorCompany.fedex
        case "NW Electrical":
            selectedType = VendorCompany.nwElectrical
        default:
            selectedType = GuestType.classic
        }
    }
    
    /// To hide all sub type buttons
    func hideButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.isHidden = true
        }
    }
    
    /// To Show right amount of buttons
    func showButtons(_ buttons: [UIButton], for types: [EntrantType]) {
        for (index, type) in types.enumerated() {
            buttons[index].setTitle(type.title, for: .normal)
            buttons[index].isHidden = false
        }
    }
    
    /// DisableFields
    func disableFields() {
        for field in formFields {
            field.isEnabled = false
            field.backgroundColor = UIColor(red: 219/255, green: 214/255, blue: 223/255, alpha: 1.0)
            field.layer.borderWidth = 2.0
            field.layer.borderColor = UIColor(red: 164/255, green: 160/255, blue: 167/255, alpha: 1.0).cgColor
        }
    }
    
    // Get Form field Text
    func getInfo(from formField: FormField) -> String? {
        return formFields.first(where: {$0.tag == formField.rawValue})?.text
    }
    
    /// Toggle form
    func toggleForm(for type: EntrantType) {
        switch type {
        case GuestType.child:
            toggleFields([.dateOfBirthField])
        case GuestType.senior:
            toggleFields([.dateOfBirthField, .firstNameField, .lastNameField])
        case GuestType.seasonPassHolder, EmployeeType.foodService, EmployeeType.rideService, EmployeeType.maintenance, EmployeeType.manager:
            toggleFields([.firstNameField, .lastNameField, .streetAddressField, .cityField, .stateField, .zipCodeField])
        case EmployeeType.contractor:
            toggleFields([.firstNameField, .lastNameField, .streetAddressField, .cityField, .stateField, .zipCodeField, .projectNumberField])
        case VendorCompany.acme, VendorCompany.orkin, VendorCompany.fedex, VendorCompany.nwElectrical:
            toggleFields([.dateOfBirthField, .firstNameField, .lastNameField, .companyField])
        default:
            break
        }
    }
    
    func toggleFields(_ fields: [FormField]) {
        for field in formFields {
            if fields.contains(where: { $0.rawValue == field.tag }) {
                field.isEnabled = true
                field.backgroundColor = .white
            } else {
                field.isEnabled = false
                field.backgroundColor = UIColor(red: 219/255, green: 214/255, blue: 223/255, alpha: 1.0)
                field.layer.borderWidth = 2.0
                field.layer.borderColor = UIColor(red: 164/255, green: 160/255, blue: 167/255, alpha: 1.0).cgColor
            }
        }
    }
    
    func setTitleWeight(target: UIButton, buttonRow: [UIButton], fontSize: CGFloat) {
        for button in buttonRow {
            button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: fontSize)
        }
        
        target.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: fontSize)
    }
    

    
    @objc func keyBoardWillShow(_ notification: Notification) {
        if let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeight = keyboardFrame.cgRectValue.size.height
        }
    }
    
    @objc func keyBoardWillHide() {
        bottomViewConstraint.constant = 30
        NSLayoutConstraint.activate([
              //topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            topStackViewConstraint
        ])
        UIView.animate(withDuration: 0.8){
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func textDidBeginEditing() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.bottomViewConstraint.constant = self.keyboardHeight + 10
            NSLayoutConstraint.deactivate([self.topStackViewConstraint])
            UIView.animate(withDuration: 0.2){
                self.view.layoutIfNeeded()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUpNotifications(for fields: [FormField]) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        for field in fields {
            NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object:
                formFields.filter({ $0.tag == field.rawValue }).first
            )
        }
    }

}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

