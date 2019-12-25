//
//  PassViewController.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 19.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import UIKit

enum ValidateButton: Int {
    case amusementAreaButton = 1
    case kitchenAreaButton
    case rideControlButton
    case maintenanceButton
    case officeButton
    case rideAccessButton
    case foodDiscountButton
    case merchDiscountButton
}

class PassViewController: UIViewController {
    
    /// Outlets
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var rideAccessLabel: UILabel!
    @IBOutlet weak var foodDiscountLabel: UILabel!
    @IBOutlet weak var merchDiscountLabel: UILabel!
    @IBOutlet weak var validationResultArea: UIView!
    @IBOutlet weak var validationResultLabel: UILabel!
    @IBOutlet weak var accessInfoLabel: UILabel!
    
    var entrantPass: EntryPass?
    
    // Amusement Park Checkpoints
    let amusementArea = ParkAccessArea(area: .amusement)
    let kitchenArea = ParkAccessArea(area: .kitchen)
    let rideControlArea = ParkAccessArea(area: .rideControl)
    let maintananceArea = ParkAccessArea(area: .maintanance)
    let officeArea = ParkAccessArea(area: .office)
    // Ride Access
    let rideTurnstile = RideTurnstile()
    let fastlaneTurnstile = FastLaneRideTurnstile()
    // Food & Merch Discount
    let parkKiosk = ParkKioskRegister()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let pass = entrantPass {
            setPassAttributes(pass: pass)
        }
        
    }
    
    /// Actions
    
    @IBAction func validatePass(_ sender: UIButton) {
        
        guard let fastLane = entrantPass?.entrant?.rideAccess.contains(where: {$0 == .skipLines}) else { return }
        
        switch sender.tag {
        case ValidateButton.amusementAreaButton.rawValue:
            updateValidationArea(for: amusementArea)
        case ValidateButton.kitchenAreaButton.rawValue:
            updateValidationArea(for: kitchenArea)
        case ValidateButton.rideControlButton.rawValue:
            updateValidationArea(for: rideControlArea)
        case ValidateButton.maintenanceButton.rawValue:
            updateValidationArea(for: maintananceArea)
        case ValidateButton.officeButton.rawValue:
            updateValidationArea(for: officeArea)
        case ValidateButton.rideAccessButton.rawValue:
            updateValidationArea(for: rideTurnstile, fastLane: fastLane)
        case ValidateButton.foodDiscountButton.rawValue:
            updateValidationArea(for: parkKiosk, typeOfDiscount: .foodDiscountButton)
        case ValidateButton.merchDiscountButton.rawValue:
            updateValidationArea(for: parkKiosk, typeOfDiscount: .merchDiscountButton)
        default:
            return
        }
        
    }
    
    @IBAction func createNewPass(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper methods
    
    func setPassAttributes(pass: EntryPass) {
        // Set pass type
        var fullName: String = ""
        var passType: String = ""
        
        guard let type = pass.entrant?.entrantType else { return }
        guard let entrantTitle = pass.entrant?.entrantType.title else { return }
        
        if let firstName = pass.entrant?.personalInformation?.firstName,
            let lastName = pass.entrant?.personalInformation?.lastName {
            fullName = "\(firstName) \(lastName)"
        } else {
            guard let placeholder = pass.entrant?.entrantType.title else { return }
            fullName = placeholder
        }

        if type.title == "Adult" || type.title == "Child" || type.title == "VIP" || type.title == "Season" || type.title == "Senior" {
            passType = "Guest Pass"
        } else if type.title == "Food" || type.title == "Ride" || type.title == "Maintenance" {
            passType = "Employee Pass"
        } else if type.title == "Manager" {
            passType = "Pass"
        } else if type.title == "Acme" || type.title == "Orkin" || type.title == "Fedex" || type.title == "NW Electrical" {
            passType = "Vendor Pass"
        }
        
        if let projectNumber = pass.entrant?.projectNumber {
            groupLabel.text = projectNumber >= 0 ? "Project Number: \(projectNumber)" : "";
        }
        fullnameLabel.text = fullName
        passTypeLabel.text = entrantTitle + " " + passType
        rideAccessLabel.text = pass.rideAccess.contains(.unlimited) ? "Unlimited Rides" : "Limited Access"
        foodDiscountLabel.text = "\(Int(pass.dicountAccess[0].discountAmount))% Food Discount"
        merchDiscountLabel.text = "\(Int(pass.dicountAccess[1].discountAmount))% Merch Discount"
    }
    
    func updateValidationArea(for checkpoint: ParkCheckpoint, fastLane: Bool = false, typeOfDiscount: ValidateButton = .foodDiscountButton) {
        guard let pass = entrantPass else { return }
        var discountInfo = ""
        
        do {
            let accessGranted = try pass.swipePass(at: checkpoint)
            
            if accessGranted {
                
                if pass.isEntrantsBirthday() {
                    showAlertWith(title: "Happy Birthday!", message: "Enjoy your stay at the park!")
                }
                
                accessInfoLabel.text = fastLane ? "Skip all lines" : ""
                
                if checkpoint.checkPointType == .kioskRegister {
                    discountInfo = typeOfDiscount == .foodDiscountButton ? "\(pass.dicountAccess[0].discountAmount)% Food Discount" : "\(pass.dicountAccess[1].discountAmount)% Merch Discount"
                    accessInfoLabel.text = discountInfo
                }

                validationResultArea.backgroundColor = .green
                validationResultLabel.text = "Access granted!"
                SoundPlayer.playSound(for: .granted)
            } else {
                validationResultArea.backgroundColor = .red
                validationResultLabel.text = "Access denied!"
                SoundPlayer.playSound(for: .denied)
                accessInfoLabel.text = ""
            }
        } catch SwipeError.swipedTooOften {
            validationResultArea.backgroundColor = .red
            validationResultLabel.text = "Access denied!"
            SoundPlayer.playSound(for: .denied)
            accessInfoLabel.text = ""
            showAlertWith(title: "Swipe Lock", message: SwipeError.swipedTooOften.rawValue)
        } catch let error {
            fatalError("\(error)")
        }

    }
    
}
